import 'dart:async';
import 'package:restart_app/restart_app.dart';
import 'package:flutter/material.dart';
import 'package:quiz_me/review.dart';

class GradedQuiz extends StatelessWidget{
  final double grade;
  final dynamic wrongQuestions;

  const GradedQuiz(this.grade, this.wrongQuestions, {super.key});

  @override
  Widget build(BuildContext context) {

    Timer(const Duration(seconds: 2), () async {
      if(grade < 100){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Review(wrongQuestions),
          ),
        );
      } else {
        await Restart.restartApp();
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text('Grade'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (grade < 100)
              Text(
                'Grade: $grade',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            if (grade == 100)
              Text(
                'Grade: $grade\n Good Job!',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            const CircularProgressIndicator(
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}