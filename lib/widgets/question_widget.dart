import 'package:flutter/material.dart';
import '../models/question.dart';

class QuestionWidget extends StatelessWidget {
  final Question q;
  final int? selectedIndex;
  final ValueChanged<int> onSelect;

  const QuestionWidget({super.key, required this.q, required this.selectedIndex, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final padding = EdgeInsets.symmetric(horizontal: width * 0.06, vertical: 16);

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(q.text, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          ...List.generate(q.options.length, (i) {
            return Card(
              child: RadioListTile<int>(
                value: i,
                groupValue: selectedIndex,
                onChanged: (v) => onSelect(v!),
                title: Text(q.options[i]),
              ),
            );
          }),
        ],
      ),
    );
  }
}
