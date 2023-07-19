abstract class Question {
  var type;
  var stem;
  var answer;

  Question(this.type, this.stem, this.answer);

  bool checkAnswer();
}