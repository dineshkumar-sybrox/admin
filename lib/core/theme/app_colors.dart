import 'package:flutter/material.dart';

class AppColors {
  // Common Flutter Colors
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;
  static const Color black12 = Colors.black12;
  static const Color black87 = Colors.black87;
  static const Color white24 = Colors.white24;
  static const Color white70 = Colors.white70;
  static const MaterialColor grey = Colors.grey;
  static const MaterialColor red = Colors.red;
  static const MaterialColor green = Colors.green;
  static const MaterialColor orange = Colors.orange;
  static const MaterialColor amber = Colors.amber;
  static const MaterialColor yellow = Colors.yellow;
  static const MaterialColor blue = Colors.blue;
  static const MaterialColor blueGrey = Colors.blueGrey;
  static const MaterialAccentColor blueAccent = Colors.blueAccent;
  static const MaterialAccentColor yellowAccent = Colors.yellowAccent;
  // Brand Colors
  static const Color primary = Color(0xFF00CFAA); // Mint Green
  static const Color secondary = Color(0xFF2E7D32);

  static const Color greenColour = Color(0xFF00A86B); // Bright Blue
  static const Color greyColour = Color(0xFF6B7A8D); // Light grey
  static const Color lightpink = Color(0xFFFF4757); // Very light grey

  // Backgrounds
  // static const Color background = Color(0xFFF8F9FD); // Very light blue-grey
  static const Color background =
      white; // Main content bg appears white in parts, or very light grey. Let's stick to F8F9FD for scaffold.
  static const Color scaffoldBackground = Color(0xFFF8F9FD);
  static const Color surface = white;
  static const Color sidebar = Color(0xFF111827); // Darker Navy
  static const Color sidebarActive = Color(0xFF1F2937);

  // Text
  static const Color textPrimary = Color(0xFF111827); // Nearly black
  static const Color textSecondary = Color(0xFF6B7280); // Cool grey
  static const Color textGrey = Color(0xFF6B7A8D); // Light grey
  static const Color textLight = white;

  // Status Colors
  static const Color success = Color(
    0xFF00CFAA,
  ); // Match primary for success often
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  static const Color btnOrange = Color(0xFFFF8C42); // Medium grey

  // Specific UI Colors
  static const Color divider = Color(0xFFE5E7EB);
  static const Color activeTagBg = Color(0xFFD1FAE5); // Light mint
  static const Color activeTagText = Color(0xFF065F46); // Dark mint

  static const Color activeGreen = Color(0xFF00A86B); // Light grey
  static const Color inactiveGrey = Color(0xFF8E9BAB);

  static const Color borderGrey = Color(0xFF6B7280); // Cool grey
  static const Color borderBlack = Color.fromARGB(17, 0, 0, 0); // Cool grey

  static const Color tableHeaderColor = Color(
    0xFF8E9BAB,
  ); // White cards with subtle shadow
  static const Color tableHeaderBGColor = Color.fromARGB(255, 231, 233, 235);

  static Color? get tableHeaderColornull => null; // Light grey
  // Raw Palette (auto-generated)
  static const Color cFF0066FF = Color(0xFF0066FF);
  static const Color cFF00894B = Color(0xFF00894B);
  static const Color cFF00A86B = Color(0xFF00A86B);
  static const Color cFF00C46B = Color(0xFF00C46B);
  static const Color cFF00CFAA = Color(0xFF00CFAA);
  static const Color cFF027A48 = Color(0xFF027A48);
  static const Color cFF059669 = Color(0xFF059669);
  static const Color cFF065F46 = Color(0xFF065F46);
  static const Color cFF0D9488 = Color(0xFF0D9488);
  static const Color cFF10B981 = Color(0xFF10B981);
  static const Color cFF111827 = Color(0xFF111827);
  static const Color cFF15803D = Color(0xFF15803D);
  static const Color cFF166534 = Color(0xFF166534);
  static const Color cFF1967D2 = Color(0xFF1967D2);
  static const Color cFF19B277 = Color(0xFF19B277);
  static const Color cFF1A1D1F = Color(0xFF1A1D1F);
  static const Color cFF1A2332 = Color(0xFF1A2332);
  static const Color cFF1B2C4E = Color(0xFF1B2C4E);
  static const Color cFF1B4332 = Color(0xFF1B4332);
  static const Color cFF1D4ED8 = Color(0xFF1D4ED8);
  static const Color cFF1E1E2C = Color(0xFF1E1E2C);
  static const Color cFF1E40AF = Color(0xFF1E40AF);
  static const Color cFF1F2937 = Color(0xFF1F2937);
  static const Color cFF22C55E = Color(0xFF22C55E);
  static const Color cFF2563EB = Color(0xFF2563EB);
  static const Color cFF2970FF = Color(0xFF2970FF);
  static const Color cFF2E5BFF = Color(0xFF2E5BFF);
  static const Color cFF2E7D32 = Color(0xFF2E7D32);
  static const Color cFF2F80ED = Color(0xFF2F80ED);
  static const Color cFF33383F = Color(0xFF33383F);
  static const Color cFF334155 = Color(0xFF334155);
  static const Color cFF3B82F6 = Color(0xFF3B82F6);
  static const Color cFF475569 = Color(0xFF475569);
  static const Color cFF4A90D9 = Color(0xFF4A90D9);
  static const Color cFF4B5563 = Color(0xFF4B5563);
  static const Color cFF4F4F4F = Color(0xFF4F4F4F);
  static const Color cFF64748B = Color(0xFF64748B);
  static const Color cFF6764FF = Color(0xFF6764FF);
  static const Color cFF67B5FF = Color(0xFF67B5FF);
  static const Color cFF6B7280 = Color(0xFF6B7280);
  static const Color cFF6B7A8D = Color(0xFF6B7A8D);
  static const Color cFF6F767E = Color(0xFF6F767E);
  static const Color cFF8A97A8 = Color(0xFF8A97A8);
  static const Color cFF8CE0B9 = Color(0xFF8CE0B9);
  static const Color cFF8E9BAB = Color(0xFF8E9BAB);
  static const Color cFF94A3B8 = Color(0xFF94A3B8);
  static const Color cFF9A9FA5 = Color(0xFF9A9FA5);
  static const Color cFF9EA5AD = Color(0xFF9EA5AD);
  static const Color cFFB1E7CE = Color(0xFFB1E7CE);
  static const Color cFFB54708 = Color(0xFFB54708);
  static const Color cFFB5C1C8 = Color(0xFFB5C1C8);
  static const Color cFFB91C1C = Color(0xFFB91C1C);
  static const Color cFFBDBDBD = Color(0xFFBDBDBD);
  static const Color cFFBFCDBE = Color(0xFFBFCDBE);
  static const Color cFFC2410C = Color(0xFFC2410C);
  static const Color cFFCBD5E1 = Color(0xFFCBD5E1);
  static const Color cFFCDD3DA = Color(0xFFCDD3DA);
  static const Color cFFD0DACC = Color(0xFFD0DACC);
  static const Color cFFD1D5DB = Color(0xFFD1D5DB);
  static const Color cFFD1FAE5 = Color(0xFFD1FAE5);
  static const Color cFFD4A000 = Color(0xFFD4A000);
  static const Color cFFD6DBE1 = Color(0xFFD6DBE1);
  static const Color cFFD8F1EB = Color(0xFFD8F1EB);
  static const Color cFFD97706 = Color(0xFFD97706);
  static const Color cFFD97A21 = Color(0xFFD97A21);
  static const Color cFFDBEAFE = Color(0xFFDBEAFE);
  static const Color cFFDC2626 = Color(0xFFDC2626);
  static const Color cFFDC6803 = Color(0xFFDC6803);
  static const Color cFFDCFCE7 = Color(0xFFDCFCE7);
  static const Color cFFDDE2E8 = Color(0xFFDDE2E8);
  static const Color cFFE0E0E0 = Color(0xFFE0E0E0);
  static const Color cFFE0F2F1 = Color(0xFFE0F2F1);
  static const Color cFFE0F2F2 = Color.fromARGB(255, 137, 55, 238);
  static const Color cFFE11D48 = Color(0xFFE11D48);
  static const Color cFFE2E8F0 = Color(0xFFE2E8F0);
  static const Color cFFE3F2FD = Color(0xFFE3F2FD);
  static const Color cFFE5E7EB = Color(0xFFE5E7EB);
  static const Color cFFE5F0FF = Color(0xFFE5F0FF);
  static const Color cFFE6EAF0 = Color(0xFFE6EAF0);
  static const Color cFFE6F9F3 = Color(0xFFE6F9F3);
  static const Color cFFE8E500 = Color(0xFFE8E500);
  static const Color cFFE8ECF0 = Color(0xFFE8ECF0);
  static const Color cFFE8F0FE = Color(0xFFE8F0FE);
  static const Color cFFE8F2FF = Color(0xFFE8F2FF);
  static const Color cFFE8F5E9 = Color(0xFFE8F5E9);
  static const Color cFFE8F5FF = Color(0xFFE8F5FF);
  static const Color cFFE8FDF2 = Color(0xFFE8FDF2);
  static const Color cFFE9EDF5 = Color(0xFFE9EDF5);
  static const Color cFFE9FBF3 = Color(0xFFE9FBF3);
  static const Color cFFEA3546 = Color(0xFFEA3546);
  static const Color cFFEA580C = Color(0xFFEA580C);
  static const Color cFFEAB308 = Color(0xFFEAB308);
  static const Color cFFEAF0FF = Color(0xFFEAF0FF);
  static const Color cFFEAF2FD = Color(0xFFEAF2FD);
  static const Color cFFECFDF3 = Color(0xFFECFDF3);
  static const Color cFFEEF0F4 = Color(0xFFEEF0F4);
  static const Color cFFEF4444 = Color(0xFFEF4444);
  static const Color cFFEFEFEF = Color(0xFFEFEFEF);
  static const Color cFFEFF6FF = Color(0xFFEFF6FF);
  static const Color cFFF0F1F3 = Color(0xFFF0F1F3);
  static const Color cFFF0F2F5 = Color(0xFFF0F2F5);
  static const Color cFFF0F4F8 = Color(0xFFF0F4F8);
  static const Color cFFF0FAF8 = Color(0xFFF0FAF8);
  static const Color cFFF0FDF4 = Color(0xFFF0FDF4);
  static const Color cFFF1F5F9 = Color(0xFFF1F5F9);
  static const Color cFFF27B86 = Color(0xFFF27B86);
  static const Color cFFF2C94C = Color(0xFFF2C94C);
  static const Color cFFF3F4F6 = Color(0xFFF3F4F6);
  static const Color cFFF4F6F9 = Color(0xFFF4F6F9);
  static const Color cFFF4FDF8 = Color(0xFFF4FDF8);
  static const Color cFFF59E0B = Color(0xFFF59E0B);
  static const Color cFFF5F5F5 = Color(0xFFF5F5F5);
  static const Color cFFF5F7FA = Color(0xFFF5F7FA);
  static const Color cFFF8F9FA = Color(0xFFF8F9FA);
  static const Color cFFF8F8F8 = Color(0xFFF8F8F8);
  static const Color cFFF8F9FD = Color(0xFFF8F9FD);
  static const Color cFFF8FAFC = Color(0xFFF8FAFC);
  static const Color cFFF97316 = Color(0xFFF97316);
  static const Color cFFF9FAFB = Color(0xFFF9FAFB);
  static const Color cFFFECACA = Color(0xFFFECACA);
  static const Color cFFFEE2E2 = Color(0xFFFEE2E2);
  static const Color cFFFEF2F2 = Color(0xFFFEF2F2);
  static const Color cFFFEF3C7 = Color(0xFFFEF3C7);
  static const Color cFFFF4757 = Color(0xFFFF4757);
  static const Color cFFFF7A29 = Color(0xFFFF7A29);
  static const Color cFFFF8A29 = Color(0xFFFF8A29);
  static const Color cFFFF8C42 = Color(0xFFFF8C42);
  static const Color cFFFF9F43 = Color(0xFFFF9F43);
  static const Color cFFFFA629 = Color(0xFFFFA629);
  static const Color cFFFFD12E = Color(0xFFFFD12E);
  static const Color cFFFFD600 = Color(0xFFFFD600);
  static const Color cFFFFE4E6 = Color(0xFFFFE4E6);
  static const Color cFFFFE8CC = Color(0xFFFFE8CC);
  static const Color cFFFFEBEE = Color(0xFFFFEBEE);
  static const Color cFFFFECEE = Color(0xFFFFECEE);
  static const Color cFFFFEDD5 = Color(0xFFFFEDD5);
  static const Color cFFFFF6ED = Color(0xFFFFF6ED);
  static const Color cFFFFF7DB = Color(0xFFFFF7DB);
  static const Color cFFFFF7E6 = Color(0xFFFFF7E6);
  static const Color cFFFFF7ED = Color(0xFFFFF7ED);
  static const Color cFFFFF8E1 = Color(0xFFFFF8E1);
  static const Color cFFFFF9ED = Color(0xFFFFF9ED);
  static const Color cFFFFFBE8 = Color(0xFFFFFBE8);

}
