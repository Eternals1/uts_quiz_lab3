import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ac;
  late final Animation<double> _fade;

  // ====== PARAM MUDAH DISENTUH ======
  static const Duration kFadeDuration = Duration(milliseconds: 800);
  static const Duration kStayDuration = Duration(milliseconds: 800);

  // Cara 1 (paling mudah): pakai persentase lebar layar
  static const double kWidthFraction = 0.42; // 42% dari lebar layar

  // Cara 2 (opsional): kunci ukuran dalam pixel. Isi nilainya untuk aktif.
  static const double? kFixedWidthPx = null; // contoh: 180.0

  // Warna latar (opsional)
  static const Color kSplashLightBg = Color(0xFFFFFFFF);
  static const Color kSplashDarkBg  = Color(0xFF232323); // beda tipis dari #2E2E2E

  @override
  void initState() {
    super.initState();
    _ac = AnimationController(vsync: this, duration: kFadeDuration);
    _fade = CurvedAnimation(parent: _ac, curve: Curves.easeOut);
    _ac.forward();

    // auto-navigate
    Future.delayed(kFadeDuration + kStayDuration, () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // pilih asset berdasarkan tema; fallback ke logo.png bila salah satu tidak ada
    final candidates = isDark
        ? ['assets/images/logo_dark.png', 'assets/images/logo.png']
        : ['assets/images/logo_light.png', 'assets/images/logo.png'];

    // hitung lebar logo
    final screenW = MediaQuery.of(context).size.width;
    final targetW = (kFixedWidthPx ?? screenW * kWidthFraction);

    return Scaffold(
      backgroundColor: isDark ? kSplashDarkBg : kSplashLightBg,
      body: Center(
        child: FadeTransition(
          opacity: _fade,
          child: _LogoImage(candidates: candidates, width: targetW),
        ),
      ),
    );
  }
}

/// Widget kecil untuk mencoba beberapa path asset (fallback)
class _LogoImage extends StatelessWidget {
  final List<String> candidates;
  final double width;
  const _LogoImage({required this.candidates, required this.width});

  @override
  Widget build(BuildContext context) {
    // langsung pakai asset pertama saja; jika kamu hanya punya satu file,
    // isi pubspec dengan nama yang sama di kedua mode dan jadinya sama saja.
    return Image.asset(
      candidates.first,
      width: width,
      fit: BoxFit.contain,
    );
  }
}
