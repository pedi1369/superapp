import 'package:flutter/material.dart';

class AppTheme {
  // ─── رنگ‌های اصلی ───
  static const Color primary = Color(0xFF8B5CF6);
  static const Color primaryLight = Color(0xFFA78BFA);
  static const Color primaryDark = Color(0xFF6D28D9);
  
  static const Color background = Color(0xFF0A0A1A);
  static const Color surface = Color(0xFF0F0F2A);
  static const Color card = Color(0xFF141432);
  
  static const Color text = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF9CA3AF);
  static const Color textMuted = Color(0xFF6B7280);
  
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFF87171);
  static const Color warning = Color(0xFFFBBF24);
  static const Color income = Color(0xFF34D399);
  static const Color expense = Color(0xFFF87171);
  
  static const Color glassBg = Color(0x14FFFFFF);
  static const Color glassBorder = Color(0x1FFFFFFF);
  static const Color divider = Color(0x15FFFFFF);

  // ─── گرادیانت‌ها ───
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient bgGradient = LinearGradient(
    colors: [Color(0xFF0A0A1A), Color(0xFF0F0F2A)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  static const LinearGradient successGradient = LinearGradient(
    colors: [Color(0xFF10B981), Color(0xFF059669)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ─── متن ───
  static TextStyle heading = const TextStyle(
    fontFamily: 'Vazirmatn',
    fontSize: 24,
    fontWeight: FontWeight.w900,
    color: text,
  );

  static TextStyle subheading = const TextStyle(
    fontFamily: 'Vazirmatn',
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: text,
  );

  static TextStyle body = const TextStyle(
    fontFamily: 'Vazirmatn',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: text,
  );

  static TextStyle caption = const TextStyle(
    fontFamily: 'Vazirmatn',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: textSecondary,
  );

  // ─── کارت شیشه‌ای ───
  static BoxDecoration get glassCard => BoxDecoration(
    color: glassBg,
    borderRadius: BorderRadius.circular(24),
    border: Border.all(color: glassBorder, width: 1),
  );

  // ─── دکمه ───
  static BoxDecoration get primaryButton => BoxDecoration(
    gradient: primaryGradient,
    borderRadius: BorderRadius.circular(18),
    boxShadow: [
      BoxShadow(
        color: primary.withOpacity(0.4),
        blurRadius: 20,
        offset: const Offset(0, 4),
      ),
    ],
  );
}
