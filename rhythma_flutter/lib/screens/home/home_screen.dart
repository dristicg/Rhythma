import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../components/shared.dart';
import '../../components/charts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Header ──────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(2, 8, 2, 20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Namaste, Aarya',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: RhythmaColors.foreground,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Day 14 · Ovulation phase',
                        style: TextStyle(
                          fontSize: 13,
                          color: RhythmaColors.mutedFg,
                        ),
                      ),
                    ],
                  ),
                ),
                _HeaderIcon(icon: Icons.language_rounded),
                const SizedBox(width: 8),
                _HeaderIcon(icon: Icons.shield_outlined),
              ],
            ),
          ),

          // ── Cycle ring + prediction ──────────────────────────
          GlassCard(
            child: Stack(
              children: [
                Positioned(
                  right: -20,
                  top: -20,
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RhythmaGradients.primary,
                    ),
                    // ignore: use_decorated_box
                  ).opacity(0.22),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        const CycleRing(day: 14, total: 28, size: 88),
                        const SizedBox(width: 18),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'NEXT PERIOD IN',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: RhythmaColors.mutedFg,
                                  letterSpacing: 1,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  const Text(
                                    '14',
                                    style: TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.w700,
                                      color: RhythmaColors.foreground,
                                      height: 1,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'days',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: RhythmaColors.mutedFg,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: RhythmaColors.foreground,
                                  ),
                                  children: [
                                    const TextSpan(text: 'Fertile window · '),
                                    TextSpan(
                                      text: 'High energy',
                                      style: const TextStyle(
                                        color: RhythmaColors.rose,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 1,
                      color: RhythmaColors.border,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _StatCell(label: 'MHS', value: '82', color: RhythmaColors.primary),
                        _StatDivider(),
                        _StatCell(label: 'CVI', value: 'Low', color: RhythmaColors.teal),
                        _StatDivider(),
                        _StatCell(label: 'Sleep', value: '7.2h', color: RhythmaColors.coral),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // ── AI Assistant CTA ────────────────────────────────
          GradientBox(
            padding: const EdgeInsets.all(18),
            child: Stack(
              children: [
                Positioned(
                  right: -8,
                  top: -8,
                  child: Icon(
                    Icons.auto_awesome_rounded,
                    size: 80,
                    color: Colors.white.withOpacity(0.15),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.auto_awesome_rounded,
                            size: 14, color: Colors.white),
                        const SizedBox(width: 6),
                        Text(
                          'RHYTHMA AI',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white.withOpacity(0.9),
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Ask me anything about your body,\nin your language.',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.chat_bubble_outline_rounded,
                                    size: 15,
                                    color: Colors.white.withOpacity(0.9)),
                                const SizedBox(width: 8),
                                Text(
                                  'Why are my periods irregular?',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(Icons.mic_rounded,
                              size: 18, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // ── Today's log ────────────────────────────────────
          SectionHeader(
            title: 'How are you feeling today?',
            action: 'Log all',
          ),
          Row(
            children: [
              _LogButton(
                icon: Icons.water_drop_outlined,
                label: 'Flow',
                color: RhythmaColors.rose,
              ),
              const SizedBox(width: 10),
              _LogButton(
                icon: Icons.favorite_border_rounded,
                label: 'Mood',
                color: RhythmaColors.coral,
              ),
              const SizedBox(width: 10),
              _LogButton(
                icon: Icons.bedtime_outlined,
                label: 'Sleep',
                color: RhythmaColors.primary,
              ),
              const SizedBox(width: 10),
              _LogButton(
                icon: Icons.air_rounded,
                label: 'Stress',
                color: RhythmaColors.teal,
              ),
            ],
          ),

          const SizedBox(height: 14),

          // ── Insight card ───────────────────────────────────
          GlassCard(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'WEEKLY INSIGHT',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: RhythmaColors.teal,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Your sleep improved 12% this week — your cycle may thank you.',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: RhythmaColors.foreground,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Consistent rest before ovulation supports hormonal balance.',
                        style: TextStyle(
                          fontSize: 13,
                          color: RhythmaColors.mutedFg,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.chevron_right_rounded,
                    color: RhythmaColors.mutedFg),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // ── Education cards ────────────────────────────────
          const SectionHeader(title: 'Learn with Rhythma'),
          SizedBox(
            height: 128,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _LearnCard(title: 'Understanding PCOS', color: RhythmaColors.rose),
                const SizedBox(width: 10),
                _LearnCard(title: 'Hormones 101', color: RhythmaColors.primary),
                const SizedBox(width: 10),
                _LearnCard(title: 'Iron-rich foods', color: RhythmaColors.coral),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Small helpers ──────────────────────────────────────────────────────────────

class _HeaderIcon extends StatelessWidget {
  final IconData icon;
  const _HeaderIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.zero,
      borderRadius: 20,
      child: SizedBox(
        width: 38,
        height: 38,
        child: Icon(icon, size: 18, color: RhythmaColors.foreground),
      ),
    );
  }
}

class _StatCell extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatCell({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 11,
                  color: RhythmaColors.mutedFg,
                  fontWeight: FontWeight.w500)),
          const SizedBox(height: 3),
          Text(value,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: color)),
        ],
      ),
    );
  }
}

class _StatDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        width: 1,
        height: 28,
        color: RhythmaColors.border,
      );
}

class _LogButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _LogButton(
      {required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GlassCard(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 6),
            Text(label,
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: RhythmaColors.foreground)),
          ],
        ),
      ),
    );
  }
}

class _LearnCard extends StatelessWidget {
  final String title;
  final Color color;

  const _LearnCard({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 152,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color, Color.lerp(color, RhythmaColors.primary, 0.5)!],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'ARTICLE',
            style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                color: Colors.white.withOpacity(0.75),
                letterSpacing: 1),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }
}

extension on Widget {
  Widget opacity(double value) =>
      Opacity(opacity: value, child: this);
}
