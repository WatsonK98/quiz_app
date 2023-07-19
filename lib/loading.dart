import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'questionparser.dart';
import 'quiz.dart';
import 'userdefine.dart';

var currentQuestion;
var parser = QuestionParser();
var finalQuiz = Quiz();
var parsed;
int currentNumber = 0;

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
            ///Must be future
            FutureBuilder <dynamic>(
              future: loadQuiz(values['username'], values['password'], '01'),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                //While the future is waiting it shows progress and let's user know
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(
                        color: Colors.green,
                      ),
                      Text(
                        //lets user know
                        'Loading Quizzes',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ],
                  );
                }
                //Once all things are completed the app moves on
                if (snapshot.hasData) {
                  Timer(const Duration(seconds: 2), () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Userdefine(finalQuiz),
                      ),
                    );
                  });
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //Lets the user know the app is ready to move on
                        const Icon(
                          Icons.check_circle_outline,
                          color: Colors.green,
                          size: 60,
                        ),
                        Text(
                          '${snapshot.data} Quizzes found',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                        ),

                      ],
                  );
                }
                return const Text('No quizzes found');
              },
            ),
          ],
        ),
      ),
    );
  }

  ///Loads the quiz from the web
  Future loadQuiz(var username, var password, var quiz) async{
    var response = await http.get(Uri.parse('https://www.cs.utep.edu/cheon/cs4381/homework/quiz/get.php?user=$username&pin=$password&quiz=quiz$quiz'));
    var decoded = json.decode(response.body);

    //Looks for every quiz available and loads a quiz object
    while (decoded['response'] == true) {
      for (int i = 0; i < decoded['quiz']['question'].length; i++) {
        currentQuestion = decoded['quiz']['question'][i];
        if (currentQuestion['type'] == 1) {
          parsed = parser.parseMulChoice(currentQuestion);
          finalQuiz.loadMulChoice(parsed);
        } else if (currentQuestion['type'] == 2) {
          parsed = parser.parseFillIn(currentQuestion);
          finalQuiz.loadFillIn(parsed);
        }
      }

      currentNumber = int.parse(quiz);
      currentNumber++;
      quiz = currentNumber < 10 ? '0$currentNumber' : '$currentNumber';
      response = await http.get(Uri.parse('https://www.cs.utep.edu/cheon/cs4381/homework/quiz/get.php?user=$username&pin=$password&quiz=quiz$quiz'));
      decoded = json.decode(response.body);
    }
    return currentNumber-1;
  }
}