import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:quiz_me/review.dart';

class GradedQuiz extends StatelessWidget{
  final double grade;
  final dynamic wrongQuestions;

  const GradedQuiz(this.grade, this.wrongQuestions, {super.key});

  @override
  Widget build(BuildContext context) {
    //Timer to move onto the review
    Timer(const Duration(seconds: 2), () async {
      //grade is less than 100 then the review is necessary
      if(grade < 100){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Review(wrongQuestions),
          ),
        );
        //if scored 100 the review is not necessary
      } else {
        exit(0);
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
            //displays the grade
            if (grade < 100)
              Text(
                'Grade: $grade',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            //congratulates the user
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