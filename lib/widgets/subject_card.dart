import 'package:flutter/material.dart';

class SubjectCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const SubjectCard({super.key, required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final spacing = MediaQuery.of(context).size.width * 0.04; // responsive
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spacing),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: spacing * 2.4),
            SizedBox(height: spacing * 0.6),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
