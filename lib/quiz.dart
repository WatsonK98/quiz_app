import 'question.dart';
import 'fillin.dart';
import 'mulchoice.dart';
import 'dart:math';

class Quiz {
  List<question> questions = [];

  ///Loads Multiple Choice questions to the Quiz database
  void loadMulChoice(MulChoice parsed) {
    questions.add(parsed);
  }

  ///Loads Fill in the blank questions to the Quiz database
  void loadFillIn(FillIn parsed) {
    questions.add(parsed);
  }

  ///Generates a quiz of user-defined length
  generateQuiz(int range) {
    if (range > questions.length) {
      return;
    }

    List<question> newQuiz = [];

    while (newQuiz.length < range) {
      var random = Random().nextInt(questions.length);
      var entry = questions[random];

      if (!newQuiz.contains(entry)) {
        newQuiz.add(entry);
      }
    }

    return newQuiz;
  }
}