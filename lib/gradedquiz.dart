import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_me/review.dart';

class GradedQuiz extends StatelessWidget{
  final double grade;
  final dynamic wrongQuestions;

  const GradedQuiz(this.grade, this.wrongQuestions, {super.key});

  @override
  Widget build(BuildContext context) {

    Timer(const Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Review(wrongQuestions),
        ),
      );
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
            Text(
              'Grade: $grade',
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