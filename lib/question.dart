abstract class question {
  var type;
  var stem;
  var answer;

  question(this.type, this.stem, this.answer);

  void display();
  bool checkAnswer(var userIn);
}