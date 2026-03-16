import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppFonts {
  AppFonts._();

  static const String saira = 'Saira';
  static const String inter = 'Inter';
}

class AppTypography {
  static TextStyle get base => const TextStyle(
    fontFamily: AppFonts.saira,
    color: AppColors.textPrimary,
  );

  static TextStyle get h1 => const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    fontFamily: AppFonts.saira,
    color: AppColors.textPrimary,
  );

  static TextStyle get h2 => const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    fontFamily: AppFonts.saira,
    color: AppColors.textPrimary,
  );

  static TextStyle get h3 => const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    fontFamily: AppFonts.saira,
    color: AppColors.textPrimary,
  );

  static TextStyle get h4 => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontFamily: AppFonts.saira,
    color: AppColors.textPrimary,
  );

  static TextStyle get bodyLarge => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    fontFamily: AppFonts.saira,
    color: AppColors.textPrimary,
  );

  static TextStyle get bodyRegular => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    fontFamily: AppFonts.saira,
    color: AppColors.textPrimary,
  );

  static TextStyle get bodySmall => const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    fontFamily: AppFonts.saira,
    color: AppColors.textSecondary,
  );
}


