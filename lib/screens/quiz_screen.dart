import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/question_widget.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, qp, _) {
        final s = qp.currentSubject!;
        final q = qp.questions(s)[qp.currentIndex];

        return Scaffold(
          appBar: AppBar(
            title: Text('Soal ${qp.currentIndex + 1}/10'),
          ),
          body: QuestionWidget(
            q: q,
            selectedIndex: null, // tidak menahan pilihan sebelumnya (bisa disimpan kalau mau)
            onSelect: (i) {
              qp.answer(i);
              if (qp.isLast) {
                Navigator.pushReplacementNamed(context, '/result', arguments: qp.score());
              } else {
                qp.next();
              }
            },
          ),
        );
      },
    );
  }
}
