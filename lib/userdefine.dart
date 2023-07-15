import 'package:flutter/material.dart';

class Userdefine extends StatelessWidget{
  final dynamic values;
  final dynamic finalQuiz;

  const Userdefine(this.values, this.finalQuiz, {super.key});

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