import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/theme_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const kGreen = Color(0xFF4CCB5E);
  static const kRed = Color(0xFFE53935);
  static const kRadiusCard = 16.0;

  String _greeting() {
    final h = DateTime.now().hour;
    if (h >= 4 && h < 11) return 'selamat pagi';
    if (h >= 11 && h < 15) return 'selamat siang';
    if (h >= 15 && h < 18) return 'selamat sore';
    return 'selamat malam';
  }

  Future<void> _editNameDialog(BuildContext context) async {
    final auth = context.read<AuthProvider>();
    final controller = TextEditingController(text: auth.displayName);
    final formKey = GlobalKey<FormState>();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Profil'),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Nama tampilan',
              border: OutlineInputBorder(),
            ),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Tidak boleh kosong' : null,
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal')),
          FilledButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                auth.updateProfile(name: controller.text.trim());
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profil diperbarui')),
                );
              }
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final themeProv = context.watch<ThemeProvider>();
    final isDark = themeProv.mode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Card sapaan
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kRadiusCard),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      child: Text(
                        auth.displayName.isNotEmpty
                            ? auth.displayName[0].toUpperCase()
                            : 'U',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'halo, ${_greeting()}, ${auth.displayName}.',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Card daftar pengaturan: Edit profil & Tema (switch)
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kRadiusCard),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.edit),
                    title: const Text('Edit profil'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _editNameDialog(context),
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    secondary: const Icon(Icons.dark_mode),
                    title: const Text('Tema'),
                    subtitle: Text(isDark ? 'Mode gelap' : 'Mode terang'),
                    value: isDark,
                    onChanged: (v) => context.read<ThemeProvider>().toggle(v),

                    // warna hijau saat ON
                    activeThumbColor: kGreen, // knob (umum)
                    thumbColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.selected))
                        return kGreen;
                      return null;
                    }),
                    trackColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return kGreen.withOpacity(0.45);
                      }
                      return null;
                    }),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Tombol Keluar merah
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text('Keluar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kRed,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // radius tombol
                  ),
                ),
                onPressed: () {
                  context.read<AuthProvider>().logout();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (_) => false);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
