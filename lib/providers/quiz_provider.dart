import 'package:flutter/foundation.dart';
import '../models/question.dart';

enum Subject { math, bahasa, english }

class QuizProvider extends ChangeNotifier {
  final Map<Subject, List<Question>> _bank = {
    Subject.math: [
      Question(text: '2 + 3 = ?', options: ['4', '5', '6', '7'], answerIndex: 1),
      Question(text: '10 - 4 = ?', options: ['4', '5', '6', '7'], answerIndex: 2),
      Question(text: '3 × 3 = ?', options: ['6', '7', '8', '9'], answerIndex: 3),
      Question(text: '12 ÷ 3 = ?', options: ['2', '3', '4', '5'], answerIndex: 2),
      Question(text: '√16 = ?', options: ['2', '3', '4', '5'], answerIndex: 2),
      Question(text: '5² = ?', options: ['10', '20', '25', '30'], answerIndex: 2),
      Question(text: '7 + 8 = ?', options: ['13', '14', '15', '16'], answerIndex: 2),
      Question(text: '9 - 5 = ?', options: ['2', '3', '4', '5'], answerIndex: 2),
      Question(text: '6 × 2 = ?', options: ['10', '11', '12', '14'], answerIndex: 2),
      Question(text: '18 ÷ 6 = ?', options: ['2', '3', '4', '5'], answerIndex: 1),
    ],
    Subject.bahasa: [
      Question(text: 'Sinonim “indah” adalah…', options: ['cantik', 'buruk', 'asing', 'seram'], answerIndex: 0),
      Question(text: 'Antonim “besar” adalah…', options: ['kecil', 'ringan', 'kencang', 'panas'], answerIndex: 0),
      Question(text: 'Huruf kapital untuk…', options: ['nama orang', 'nama benda', 'kata umum', 'kata depan'], answerIndex: 0),
      Question(text: 'Kalimat efektif itu…', options: ['hemat & jelas', 'panjang', 'berulang', 'puitis'], answerIndex: 0),
      Question(text: 'Imbuhan me- + baca =', options: ['membaca', 'dibaca', 'bacaan', 'terbaca'], answerIndex: 0),
      Question(text: 'Gagasan utama paragraf disebut…', options: ['ide pokok', 'judul', 'ringkasan', 'simpulan'], answerIndex: 0),
      Question(text: 'Kata baku dari “aktifitas”…', options: ['aktivitas', 'aktifitas', 'aktipitas', 'aktiv'], answerIndex: 0),
      Question(text: 'Kata depan “di” dipisah saat…', options: ['menunjuk tempat', 'imbuhan', 'kata benda', 'serapan'], answerIndex: 0),
      Question(text: 'Antonim “murah”…', options: ['mahal', 'bagus', 'cepat', 'keras'], answerIndex: 0),
      Question(text: 'Sinonim “cerdas”…', options: ['pintar', 'pelit', 'pendek', 'lebar'], answerIndex: 0),
    ],
    Subject.english: [
      Question(text: 'She ___ a doctor.', options: ['am', 'is', 'are', 'be'], answerIndex: 1),
      Question(text: 'They ___ playing.', options: ['is', 'are', 'am', 'be'], answerIndex: 1),
      Question(text: 'Past of “go” is…', options: ['goed', 'went', 'gone', 'going'], answerIndex: 1),
      Question(text: 'Plural of “child” is…', options: ['childs', 'childes', 'children', 'childrens'], answerIndex: 2),
      Question(text: 'Opposite of “hot”…', options: ['cold', 'cool', 'heat', 'ice'], answerIndex: 0),
      Question(text: 'He ___ football.', options: ['play', 'plays', 'played', 'playing'], answerIndex: 1),
      Question(text: 'Comparative of “big”…', options: ['biger', 'bigger', 'biggest', 'more big'], answerIndex: 1),
      Question(text: 'Synonym of “happy”…', options: ['sad', 'glad', 'mad', 'bad'], answerIndex: 1),
      Question(text: 'Past of “see”…', options: ['seed', 'saw', 'seen', 'see'], answerIndex: 1),
      Question(text: 'Preposition: “___ Monday”', options: ['on', 'in', 'at', 'by'], answerIndex: 0),
    ],
  };

  Subject? currentSubject;
  int currentIndex = 0;
  int correct = 0;
  final Map<Subject, List<int?>> _answers = {
    Subject.math: List<int?>.filled(10, null),
    Subject.bahasa: List<int?>.filled(10, null),
    Subject.english: List<int?>.filled(10, null),
  };

  List<Question> questions(Subject s) => _bank[s]!;

  void start(Subject s) {
    currentSubject = s;
    currentIndex = 0;
    correct = 0;
    // keep previous answers? reset to null for new attempt
    _answers[s] = List<int?>.filled(10, null);
    notifyListeners();
  }

  void answer(int optionIndex) {
    final s = currentSubject!;
    _answers[s]![currentIndex] = optionIndex;
    if (questions(s)[currentIndex].answerIndex == optionIndex) {
      correct++;
    }
    notifyListeners();
  }

  bool get isLast => currentIndex >= 9;

  void next() {
    if (!isLast) {
      currentIndex++;
      notifyListeners();
    }
  }
  
  List<int?> answers(Subject s) => _answers[s]!;

  int questionCount(Subject s) => _bank[s]!.length;

  int correctIndex(Subject s, int i) => _bank[s]![i].answerIndex;

  int score() => correct;
}


