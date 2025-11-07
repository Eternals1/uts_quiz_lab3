import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/quiz_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const kGreen = Color(0xFF4CCB5E);
  static const kRadius = 9.0;

  @override
  Widget build(BuildContext context) {
    final name = context.watch<AuthProvider>().displayName;

    return Scaffold(
      appBar: AppBar(
        title: Text('Hai, $name', style: const TextStyle(fontWeight: FontWeight.w700)),
        actions: [
          IconButton(
            tooltip: 'Profil',
            onPressed: () => Navigator.pushNamed(context, '/profile'),
            icon: const Icon(Icons.person),
            color: kGreen, // ikon appbar hijau
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: kGreen), // titik tiga hijau
            onSelected: (v) {
              if (v == 'logout') {
                context.read<AuthProvider>().logout();
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
            itemBuilder: (c) => const [
              PopupMenuItem(value: 'logout', child: Text('Logout')),
            ],
          ),
        ],
      ),

      // List kartu vertikal
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
        children: [
          _SubjectTile(
            title: 'Matematika',
            icon: Icons.calculate,
            onTap: () {
              final qp = context.read<QuizProvider>()..start(Subject.math);
              Navigator.pushNamed(context, '/quiz');
            },
          ),
          const SizedBox(height: 12),
          _SubjectTile(
            title: 'Bahasa Indonesia',
            icon: Icons.menu_book,
            onTap: () {
              final qp = context.read<QuizProvider>()..start(Subject.bahasa);
              Navigator.pushNamed(context, '/quiz');
            },
          ),
          const SizedBox(height: 12),
          _SubjectTile(
            title: 'Bahasa Inggris',
            icon: Icons.translate,
            onTap: () {
              final qp = context.read<QuizProvider>()..start(Subject.english);
              Navigator.pushNamed(context, '/quiz');
            },
          ),
        ],
      ),

      // Navbar bernuansa hijau
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: kGreen.withOpacity(0.18),
          labelTextStyle: WidgetStateProperty.resolveWith(
            (states) => TextStyle(
              fontWeight: FontWeight.w600,
              color: states.contains(WidgetState.selected) ? kGreen : null,
            ),
          ),
          iconTheme: WidgetStateProperty.resolveWith(
            (states) => IconThemeData(
              color: states.contains(WidgetState.selected) ? kGreen : null,
            ),
          ),
        ),
        child: NavigationBar(
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Beranda'),
            NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profil'),
          ],
          selectedIndex: 0,
          onDestinationSelected: (i) {
            if (i == 1) Navigator.pushNamed(context, '/profile');
          },
        ),
      ),
    );
  }
}

/// Kartu subject hijau (radius 9), logo kiri + judul
class _SubjectTile extends StatelessWidget {
  const _SubjectTile({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  static const kGreen = Color(0xFF4CCB5E);
  static const kRadius = 9.0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(kRadius),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: kGreen,
          borderRadius: BorderRadius.circular(kRadius), // radius = 9
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              // Kotak ikon outline putih tipis
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: kGreen.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.9),
                    width: 1.2,
                  ),
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
