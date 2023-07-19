import 'question.dart';

class FillIn extends Question {
  String filledAnswer = '';
  FillIn(var type, var stem, var answer) : super(type, stem, answer);

  ///Checks to see if answer is correct
  @override
  bool checkAnswer() {
    return answer.contains[filledAnswer];
  }
}