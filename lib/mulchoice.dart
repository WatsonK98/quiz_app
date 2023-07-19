import 'question.dart';

class MulChoice extends Question {
  List<dynamic> options;
  var chosen = 0;
  int selectedOptionIndex = -1;

  MulChoice(var type, var stem, var answer, this.options)
      : super(type, stem, answer);

  ///Checks the answer
  @override
  bool checkAnswer() {
    if(options.indexOf(answer) == selectedOptionIndex){
      return true;
    } else {
      return false;
    }
  }
}