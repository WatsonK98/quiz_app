import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'questionparser.dart';
import 'quiz.dart';

class Loading extends StatelessWidget{
  final dynamic values;

  const Loading (this.values, {super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text('Quiz Zap!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FutureBuilder <dynamic>(
              future: loadQuiz(values['username'], values['password'], '01'),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (snapshot.hasData) {
                  var parser = QuestionParser();
                  var finalQuiz = Quiz();
                  var currentQuestion;
                  var parsed;
                  var quiz = '01';
                  dynamic response = snapshot.data['response'];

                  while (response == true) {
                    for (int i = 0; i < response['quiz']['question'].length; i++) {
                      currentQuestion = response['quiz']['question'][i];
                      if (currentQuestion['type'] == 1) {
                        parsed = parser.parseMulChoice(currentQuestion);
                        finalQuiz.loadMulChoice(parsed);
                      } else if (currentQuestion['type'] == 2) {
                        parsed = parser.parseFillIn(currentQuestion);
                        finalQuiz.loadFillIn(parsed);
                      }
                    }
                    int currentNumber = int.parse(quiz);
                    currentNumber++;
                    quiz = currentNumber < 10 ? '0$currentNumber' : '$currentNumber';
                    response = loadQuiz(values['username'], values['password'], quiz);
                  }
                  return Text(
                      '$quiz Quizzes found',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),);
                }
                return const Text('No quizzes found');
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> loadQuiz(var username, var password, var quiz) async{
    var url = 'https://www.cs.utep.edu/cheon/cs4381/homework/quiz/login.php?user=$username&pin=$password&quiz=quiz$quiz';
    var response = await http.get(Uri.parse(url));
    var decoded = json.decode(response.body);
    return Future.delayed(const Duration(milliseconds: 50), () => decoded);
  }
}