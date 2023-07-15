abstract class Question {
  var type;
  var stem;
  var answer;

  Question(this.type, this.stem, this.answer);

  void display();
  bool checkAnswer(var userIn);
}