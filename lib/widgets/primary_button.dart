import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final EdgeInsets? padding;
  const PrimaryButton({super.key, required this.label, required this.onPressed, this.padding});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(padding: padding ?? const EdgeInsets.symmetric(vertical: 14)),
        child: Text(label),
      ),
    );
  }
}
