import 'package:flutter/material.dart';

class AppColors {
  // BRAND
  static const greenBrand = Color(0xFF34C759); // ganti kalau perlu
  static const darkText   = Color(0xFF2E2E2E); // “Ku” saat light
  static const lightText  = Color(0xFFFFFFFF); // “Ku” saat dark

  // Background Splash (hindari tabrakan dgn logo #2E2E2E)
  // Pakai sedikit beda: #232323
  static const splashDarkBg  = Color(0xFF232323);
  static const splashLightBg = Color(0xFFFFFFFF);

  // (warna tema utama tetap boleh kamu ubah)
  static const primary   = Color(0xFF4F46E5);
  static const secondary = Color(0xFF06B6D4);
}

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.primary,
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
  scaffoldBackgroundColor: const Color(0xFFF7F7FB),
  fontFamily: 'Poppins',
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.primary,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.dark,
  ),
  fontFamily: 'Poppins',
);
