import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../components/shared.dart';
import '../../services/sms_service.dart';

/// SMS Health Summary screen.
/// Users configure a phone number to receive summaries via SMS, useful in
/// low-data areas, and can trigger an on-demand summary right now.
class SmsScreen extends StatefulWidget {
  const SmsScreen({Key? key}) : super(key: key);

  @override
  State<SmsScreen> createState() => _SmsScreenState();
}

class _SmsScreenState extends State<SmsScreen> {
  final _sms = SmsService();
  final _phoneCtrl = TextEditingController();
  bool _smsEnabled = false;
  bool _saving = false;
  bool _sending = false;
  bool _loading = true;

  // The phone number is loaded from the user's saved settings (their
  // "profile" for this feature) and reused for sending, no separate
  // manual-entry field for the Send action itself.
  static const _summaryMessage =
      '🌸 Rhythma Health Summary\n'
      'This is your on-demand summary from Rhythma.\n'
      'Open the app for your latest cycle insights.\n'
      'Reply STOP to unsubscribe.';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  @override
  void dispose() {
    _phoneCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadSettings() async {
    setState(() => _loading = true);
    try {
      final settings = await _sms.getSettings();
      setState(() {
        _phoneCtrl.text = (settings['phoneNumber'] as String?) ?? '';
        _smsEnabled = settings['enabled'] as bool? ?? false;
      });
    } catch (_) {
      // No saved settings yet is fine, fields just stay empty.
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _saveSettings() async {
    final phone = _phoneCtrl.text.trim();
    if (_smsEnabled && phone.isEmpty) {
      _showSnack('Please enter a phone number', isError: true);
      return;
    }

    setState(() => _saving = true);
    try {
      await _sms.saveSettings(phoneNumber: phone, enabled: _smsEnabled);
      _showSnack('SMS settings saved successfully!');
    } catch (e) {
      _showSnack(_friendlyError(e), isError: true);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _sendSummaryNow() async {
    final phone = _phoneCtrl.text.trim();
    if (phone.isEmpty) {
      _showSnack('Add and save a phone number first', isError: true);
      return;
    }

    setState(() => _sending = true);
    try {
      await _sms.sendSummary(phoneNumber: phone, message: _summaryMessage);
      _showSnack('Summary sent to your phone!');
    } catch (e) {
      _showSnack(_friendlyError(e), isError: true);
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  /// Covers the feedback cases issue #26 asks for: success (handled at the
  /// call sites above), network failures, authentication failures, and
  /// backend rate limiting, falling back to the backend's own error detail
  /// (e.g. an invalid phone format, or a Twilio-side error) when it's none
  /// of those.
  String _friendlyError(Object e) {
    if (e is DioException) {
      final status = e.response?.statusCode;
      if (status == 429) {
        return "You can send one summary per minute, please wait a bit and try again.";
      }
      if (status == 401) {
        return "Your session has expired. Please log in again.";
      }
      final data = e.response?.data;
      if (data is Map && data['detail'] is String && (data['detail'] as String).isNotEmpty) {
        return data['detail'] as String;
      }
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.unknown) {
        return "Couldn't reach the server. Check your connection and try again.";
      }
      return "Something went wrong. Please try again.";
    }
    return "Something went wrong. Please try again.";
  }

  void _showSnack(String text, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: isError ? Colors.red : RhythmaColors.teal,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasPhone = _phoneCtrl.text.trim().isNotEmpty;

    // Matches the same Container(gradient) + Scaffold(transparent) + AppBar
    // wrapper every other pushed settings sub-screen uses (see
    // theme_screen.dart / language_screen.dart). Without it, this screen
    // rendered on a bare black canvas with no back button and no Material
    // text styling, since it was built to be a tab body, not a pushed route.
    return Container(
      decoration: BoxDecoration(gradient: RhythmaGradients.bg),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('SMS Summaries'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: _loading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Stay informed even without the app',
                        style: TextStyle(fontSize: 13, color: RhythmaColors.mutedFg)),
                    const SizedBox(height: 20),

                    // Info card
                    GlassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              TintedIcon(icon: Icons.sms_rounded, color: RhythmaColors.teal),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text('Weekly Health Summary',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: RhythmaColors.foreground)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Every week, Rhythma will send you a brief summary of your '
                            'cycle status, health score, and any important patterns, '
                            'directly to your phone via SMS. Works without data or the app.',
                            style: TextStyle(
                                fontSize: 13, color: RhythmaColors.mutedFg, height: 1.5),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Config card
                    GlassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Configuration',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: RhythmaColors.foreground)),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _phoneCtrl,
                            keyboardType: TextInputType.phone,
                            onChanged: (_) => setState(() {}),
                            decoration: const InputDecoration(
                              labelText: 'Phone Number',
                              hintText: '+91 98765 43210',
                              prefixIcon: Icon(Icons.phone_rounded),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: Text('Enable weekly SMS',
                                    style: TextStyle(fontSize: 14, color: RhythmaColors.foreground)),
                              ),
                              Switch(
                                value: _smsEnabled,
                                onChanged: (v) => setState(() => _smsEnabled = v),
                                activeThumbColor: RhythmaColors.primary,
                                activeTrackColor: RhythmaColors.primary.withValues(alpha: 0.5),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _saving ? null : _saveSettings,
                              child: _saving
                                  ? const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                                  : const Text('Save Settings'),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // On-demand summary, a real action wired to the backend,
                    // replacing the previous static "Sample SMS" placeholder.
                    GlassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Send a Summary Now',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: RhythmaColors.foreground)),
                          const SizedBox(height: 4),
                          Text(
                            hasPhone
                                ? 'Sends the message below to ${_phoneCtrl.text.trim()}.'
                                : 'Add and save a phone number above first.',
                            style: TextStyle(fontSize: 12, color: RhythmaColors.mutedFg),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: RhythmaColors.surfaceMuted,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              _summaryMessage,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: RhythmaColors.foreground,
                                  height: 1.6,
                                  fontFamily: 'monospace'),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: (_sending || !hasPhone) ? null : _sendSummaryNow,
                              child: _sending
                                  ? const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                                  : const Text('Send Summary Now'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}