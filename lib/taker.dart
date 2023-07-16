import 'package:flutter/material.dart';
import 'package:quiz_me/mulchoice.dart';
import 'package:quiz_me/fillin.dart';


class Taker extends StatelessWidget{
  final dynamic randomQuiz;

  const Taker(this.randomQuiz, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: const Text('Quiz Builder'),
        ),
        body: const QuizScreen(),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;

  void goToNextQuestion() {
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        // Handle end of the quiz
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(currentQuestion.stem),
            ListView.builder(
              shrinkWrap: true,
              itemCount: currentQuestion.options.length,
              itemBuilder: (BuildContext context, int index) {
                final option = currentQuestion.options[index];

                return CheckboxListTile(
                  checkColor: Colors.green,
                  title: Text(option),
                  value: false, // Change this to the appropriate value
                  onChanged: (bool? value) {
                    // Add your logic here
                  },
                );
              },
            ),
            ElevatedButton(
              onPressed: goToNextQuestion,
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}