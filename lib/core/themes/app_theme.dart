import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // === Brand Colors ===
  static const Color primary = Color(0xFFCD1C18);
  static const Color primaryLight = Color(0xFFFFA896);
  static const Color primaryDark = Color(0xFF9B1313);
  static const Color deep = Color(0xFF38000A);

  // === Background & Surface ===
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF5F5F5);
  static const Color scaffoldBackground = Color(0xFFF9F9F9);

  // === Text Colors ===
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF555555);
  static const Color textDisabled = Color(0xFF9E9E9E);
  static const Color textHint = Color(0xFF8A8A8A);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnSurface = Color(0xFF1A1A1A);

  // === Border & Divider ===
  static const Color border = Color(0xFFE0E0E0);
  static const Color borderFocused = primary;
  static const Color divider = Color(0xFFE6E6E6);

  // === State / Feedback Colors ===
  static const Color success = Color(0xFF2E7D32);
  static const Color successLight = Color(0xFFC8E6C9);

  static const Color warning = Color(0xFFF9A825);
  static const Color warningLight = Color(0xFFFFF3C4);

  static const Color error = Color(0xFFD32F2F);
  static const Color errorLight = Color(0xFFFFCDD2);

  static const Color info = Color(0xFF0288D1);
  static const Color infoLight = Color(0xFFB3E5FC);

  // === Button States ===
  static const Color disabled = Color(0xFFBDBDBD);
  static const Color overlay = Color(0x1F000000); // ripple / pressed

  // === Shadow ===
  static const Color shadow = Color(0x33000000);
}

final ThemeData appTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,

  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: Colors.white,
    secondary: AppColors.primaryLight,
    onSecondary: Colors.white,
    tertiary: AppColors.primaryDark,
    onTertiary: Colors.white,
    error: Colors.red.shade700,
    onError: Colors.white,
    surface: AppColors.surface,
    onSurface: AppColors.textPrimary,
  ),

  scaffoldBackgroundColor: AppColors.background,

  // Typography with Google Fonts
  // Typography with Google Fonts (Inter)
  textTheme: GoogleFonts.interTextTheme().copyWith(
    // Display
    displayLarge: GoogleFonts.inter(
      fontSize: 57,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
    ),
    displayMedium: GoogleFonts.inter(
      fontSize: 45,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
    ),
    displaySmall: GoogleFonts.inter(
      fontSize: 36,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),

    // Headline
    headlineLarge: GoogleFonts.inter(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    headlineMedium: GoogleFonts.inter(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    headlineSmall: GoogleFonts.inter(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),

    // Title
    titleLarge: GoogleFonts.inter(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    titleMedium: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimary,
    ),
    titleSmall: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.textSecondary,
    ),

    // Body
    bodyLarge: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimary,
      height: 1.5,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondary,
      height: 1.5,
    ),
    bodySmall: GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondary,
      height: 1.4,
    ),

    // Label (Buttons, Chips, etc.)
    labelLarge: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColors.textOnPrimary,
    ),
    labelMedium: GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.textOnPrimary,
    ),
    labelSmall: GoogleFonts.inter(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: AppColors.textSecondary,
    ),
  ),

  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
    titleTextStyle: GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.primaryLight),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.primary, width: 2),
    ),
    labelStyle: TextStyle(color: AppColors.primaryDark),
  ),
);
