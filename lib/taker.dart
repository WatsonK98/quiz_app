import 'package:flutter/material.dart';

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
      ),
    );
  }
}