import 'package:flutter/material.dart';

class GradeQuiz extends StatelessWidget{
  final double grade;
  final List wrongQuestions;

  const GradeQuiz(this.grade, this.wrongQuestions, {super.key});

  @override
  Widget build(BuildContext context) {
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
          ],
        ),
      ),
    );
  }
}