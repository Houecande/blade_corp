import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const bg = Color(0xFF080B14);
  static const bg2 = Color(0xFF0D1120);
  static const bg3 = Color(0xFF111827);
  static const card = Color(0xFF0F1729);
  static const cyan = Color(0xFF00D4FF);
  static const violet = Color(0xFF8B5CF6);
  static const pink = Color(0xFFEC4899);
  static const text = Color(0xFFE2E8F0);
  static const muted = Color(0xFF64748B);
  static const border = Color(0x12FFFFFF);

  static const gradCyan = LinearGradient(
    colors: [cyan, violet],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const gradPink = LinearGradient(
    colors: [pink, Color(0xFFEC4899)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const gradBlue = LinearGradient(
    colors: [cyan, Color(0xFF0EA5E9)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const gradViolet = LinearGradient(
    colors: [violet, Color(0xFF6D28D9)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class AppTheme {
  static ThemeData get theme => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.bg,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.cyan,
          secondary: AppColors.violet,
          surface: AppColors.card,
        ),
        textTheme: GoogleFonts.spaceGroteskTextTheme(
          ThemeData.dark().textTheme,
        ).apply(bodyColor: AppColors.text, displayColor: AppColors.text),
      );
}

// Navigation items
const navItems = ['Expertise', 'Projets', 'Stack', 'Process', 'Contact'];

// Scroll keys
final accueilKey = GlobalKey();
final expertiseKey = GlobalKey();
final projetsKey = GlobalKey();
final stackKey = GlobalKey();
final processKey = GlobalKey();
final contactKey = GlobalKey();
