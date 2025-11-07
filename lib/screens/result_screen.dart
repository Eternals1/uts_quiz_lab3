import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  String _letter(int i) => String.fromCharCode(97 + i); // 0->a, 1->b, ...

  @override
  Widget build(BuildContext context) {
    // skor tetap diterima via arguments (opsional buat header)
    final int score = ModalRoute.of(context)!.settings.arguments as int? ?? 0;

    return Consumer<QuizProvider>(
      builder: (context, qp, _) {
        final s = qp.currentSubject!;
        final total = qp.questionCount(s);
        final userAnswers = qp.answers(s);
        final questions = qp.questions(s);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Hasil & Pembahasan'),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Header ringkas
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '🎉 Selamat! Benar $score dari $total.',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 12),

              // Loop semua soal
              ...List.generate(total, (index) {
                final q = questions[index];
                final correctIdx = q.answerIndex;
                final userIdx = userAnswers[index];

                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nomor + soal
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          child: Text(
                            'Nomor ${index + 1}: "${q.text}"',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        const Divider(height: 1),

                        // Semua opsi
                        ...List.generate(q.options.length, (i) {
                          final isCorrect = i == correctIdx;
                          final isUserWrong = (userIdx != null) && (i == userIdx) && (userIdx != correctIdx);

                          Color? bg;
                          Color? fg;
                          if (isCorrect) {
                            bg = Colors.green.withOpacity(0.12);
                            fg = Colors.green.shade800;
                          } else if (isUserWrong) {
                            bg = Colors.red.withOpacity(0.12);
                            fg = Colors.red.shade800;
                          }

                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: bg,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isCorrect
                                    ? Colors.green
                                    : isUserWrong
                                        ? Colors.red
                                        : Theme.of(context).dividerColor,
                              ),
                            ),
                            child: ListTile(
                              dense: false,
                              title: Text(
                                'Pilihan ${_letter(i)})  ${q.options[i]}',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: fg),
                              ),
                              trailing: isCorrect
                                  ? const Icon(Icons.check_circle, color: Colors.green)
                                  : isUserWrong
                                      ? const Icon(Icons.cancel, color: Colors.red)
                                      : null,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                );
              }),

              // ... tetap sama daftar soal ...

            const SizedBox(height: 8),

            SizedBox(
              width: double.infinity, // >> lebih lebar (full width)
              child: FilledButton(
                style: FilledButton.styleFrom(
                   backgroundColor: Color(0xFF4CCB5E),            // hijau
                   foregroundColor: Colors.white,
                   padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                   shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),      // radius = 8
                  ),
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
              },
              child: const Text('Kembali ke Beranda'),
            ),
          ),

            ],
          ),
        );
      },
    );
  }
}
