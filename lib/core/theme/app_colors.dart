import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors
  static const Color primary = Color(0xFF00CFAA); // Mint Green
  static const Color secondary = Color(0xFF2E7D32);

  // Backgrounds
  // static const Color background = Color(0xFFF8F9FD); // Very light blue-grey
  static const Color background = Colors
      .white; // Main content bg appears white in parts, or very light grey. Let's stick to F8F9FD for scaffold.
  static const Color scaffoldBackground = Color(0xFFF8F9FD);
  static const Color surface = Colors.white;
  static const Color sidebar = Color(0xFF111827); // Darker Navy
  static const Color sidebarActive = Color(0xFF1F2937);

  // Text
  static const Color textPrimary = Color(0xFF111827); // Nearly black
  static const Color textSecondary = Color(0xFF6B7280); // Cool grey
  static const Color textLight = Colors.white;

  // Status Colors
  static const Color success = Color(
    0xFF00CFAA,
  ); // Match primary for success often
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  // Specific UI Colors
  static const Color divider = Color(0xFFE5E7EB);
  static const Color activeTagBg = Color(0xFFD1FAE5); // Light mint
  static const Color activeTagText = Color(0xFF065F46); // Dark mint
}
