import 'question.dart';

class FillIn extends Question {
  FillIn(var type, var stem, var answer) : super(type, stem, answer);

  ///Prints the question
  @override
  String display() {
    return stem;
  }

  ///Checks to see if answer is correct
  @override
  bool checkAnswer(var userIn) {
    return answer.contains(userIn);
  }
}