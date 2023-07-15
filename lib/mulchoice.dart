import 'question.dart';

class MulChoice extends Question {
  List<dynamic> options;

  MulChoice(var type, var stem, var answer, this.options)
      : super(type, stem, answer);

  ///Prints the question
  @override
  String display() {
    String stemFormat = stem;
    for (int i = 0; i < options.length; i++) {
      stemFormat += '\n   ${i + 1}. ${options[i]}';
    }
    return stemFormat;
  }

  ///Checks the answer
  @override
  bool checkAnswer(var userIn) {
    try {
      return userIn == answer;
    } on FormatException {
      return false;
    }
  }
}