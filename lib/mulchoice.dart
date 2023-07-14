import 'question.dart';

class mulchoice extends question {
  List<dynamic> options;

  mulchoice(var type, var stem, var answer, this.options)
      : super(type, stem, answer);

  ///Prints the question
  @override
  void display() {
    print(stem);
    for (int i = 0; i < options.length; i++) {
      print('   ${i + 1}. ${options[i]}');
    }
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