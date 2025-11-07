import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/app_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final idC = TextEditingController();
  final passC = TextEditingController();
  bool obscure = true;

  // ---- KNOBS (boleh kamu atur cepat) ----
  static const double kLogoFraction = 0.36; // 36% dari lebar layar
  static const double kLogoMaxPx = 220;     // batas maksimal px
  static const double kCardRadius = 10;
  static const double kCardPadding = 20;
  static const double kSpacing = 14;

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final logoW = min(screenW * kLogoFraction, kLogoMaxPx);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // pakai logo light/dark kalau kamu sediakan; fallback ke logo.png
    final logoPath = isDark
        ? 'assets/images/logo_dark.png'
        : 'assets/images/logo_light.png';

    return Scaffold(
      // biar mirip mockup gelap; kalau mau ikut theme scaffold biarkan default
      backgroundColor: isDark ? const Color(0xFF101014) : null,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // LOGO (lebih besar & di atas)
                  Image.asset(
                    logoPath,
                    width: logoW,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 24),

                  // CARD berisi ID, Password, Button hijau
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kCardRadius),
                    ),
                    color: Theme.of(context).colorScheme.surface,
                    child: Padding(
                      padding: const EdgeInsets.all(kCardPadding),
                      child: Column(
                        children: [
                          AppTextField(
                            controller: idC,
                            hint: 'ID',
                            prefix: const Icon(Icons.person),
                          ),
                          const SizedBox(height: kSpacing),
                          AppTextField(
                            controller: passC,
                            hint: 'Password',
                            obscure: obscure,
                            prefix: const Icon(Icons.lock),
                            suffix: IconButton(
                              icon: Icon(
                                obscure ? Icons.visibility : Icons.visibility_off,
                              ),
                              onPressed: () => setState(() => obscure = !obscure),
                            ),
                          ),
                          const SizedBox(height: kSpacing + 2),

                          // Tombol "Masuk" warna #4CCB5E
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              style: FilledButton.styleFrom(
                                backgroundColor: const Color(0xFF4CCB5E),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                final ok = context.read<AuthProvider>().login(
                                      idC.text.trim(),
                                      passC.text.trim(),
                                    );
                                if (ok) {
                                  Navigator.pushReplacementNamed(context, '/home');
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('ID/Password tidak boleh kosong'),
                                    ),
                                  );
                                }
                              },
                              child: const Text('Masuk'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
