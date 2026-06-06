import 'package:flutter/material.dart';

/// Rhythma design tokens — mirrors the web CSS :root variables exactly.
class RhythmaColors {
  // Primary — Soft Lavender  (oklch 0.62 0.13 305 ≈ #8B5CF6 adjusted)
  static const Color primary = Color(0xFF9B72CF);
  static const Color primaryFg = Color(0xFFFCFAFF);
  static const Color lavender = Color(0xFFD8C8F0);

  // Rose Pink  (oklch 0.72 0.14 350 ≈)
  static const Color rose = Color(0xFFE07AAD);
  static const Color roseFg = Color(0xFFFCFAFF);

  // Teal  (oklch 0.68 0.10 195)
  static const Color teal = Color(0xFF52B3B0);
  static const Color tealFg = Color(0xFFFCFAFF);

  // Warm Coral  (oklch 0.74 0.13 35)
  static const Color coral = Color(0xFFE8946A);
  static const Color coralFg = Color(0xFFFCFAFF);

  // Backgrounds
  static const Color background = Color(0xFFFDF8FF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFF5F0FA);

  // Foreground
  static const Color foreground = Color(0xFF2D1F47);
  static const Color mutedFg = Color(0xFF7A6E8A);

  // Border
  static const Color border = Color(0xFFE8DFF5);

  // Glass card helper — used many places
  static Color get glassCard => surface.withOpacity(0.75);
  static Color get glassBorder => lavender.withOpacity(0.4);
}

class RhythmaGradients {
  static const LinearGradient primary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [RhythmaColors.primary, RhythmaColors.rose],
  );

  static const LinearGradient bg = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFDF8FF), Color(0xFFF8EEF8)],
  );

  static LinearGradient tinted(Color color) => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          color.withOpacity(0.18),
          color.withOpacity(0.08),
        ],
      );
}

class RhythmaTheme {
  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        fontFamily: 'Nunito',
        colorScheme: ColorScheme.light(
          primary: RhythmaColors.primary,
          secondary: RhythmaColors.teal,
          tertiary: RhythmaColors.rose,
          surface: RhythmaColors.surface,
          background: RhythmaColors.background,
          onPrimary: RhythmaColors.primaryFg,
          onSecondary: RhythmaColors.tealFg,
          onSurface: RhythmaColors.foreground,
          onBackground: RhythmaColors.foreground,
        ),
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          iconTheme: IconThemeData(color: RhythmaColors.foreground),
          titleTextStyle: TextStyle(
            color: RhythmaColors.foreground,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: 'Nunito',
          ),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: RhythmaColors.foreground,
            height: 1.2,
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: RhythmaColors.foreground,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: RhythmaColors.foreground,
          ),
          bodyLarge: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: RhythmaColors.foreground,
            height: 1.5,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: RhythmaColors.foreground,
            height: 1.4,
          ),
          labelSmall: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: RhythmaColors.mutedFg,
            letterSpacing: 0.8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: RhythmaColors.primary,
            foregroundColor: RhythmaColors.primaryFg,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: RhythmaColors.surfaceMuted,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide:
                const BorderSide(color: RhythmaColors.primary, width: 1.5),
          ),
          hintStyle: const TextStyle(
            color: RhythmaColors.mutedFg,
            fontSize: 14,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        ),
      );
}
