import 'package:flutter/material.dart';

class Loading extends StatelessWidget{
  const Loading({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Loading Page',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: const Text('Loading...'),
        ),
        body: const QuizAppLoading(),
      ),
    );
  }
}

class QuizAppLoading extends StatefulWidget {
  const QuizAppLoading({super.key});

  @override
  State<QuizAppLoading> createState() => _QuizAppLoading();
}

class _QuizAppLoading extends State<QuizAppLoading>{
  @override
  Widget build(BuildContext context){
    return Scaffold();
  }
}