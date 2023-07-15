import 'fillin.dart';
import 'mulchoice.dart';

class QuestionParser {
  var question;

  ///Parses multiple choice questions
  parseMulChoice(var response) {
    question = MulChoice(response['type'], response['stem'], response['answer'],
        response['option']);
    return question;
  }

  ///Parses Fill In the Blank questions
  parseFillIn(var response) {
    question = FillIn(response['type'], response['stem'], response['answer']);
    return question;
  }
}