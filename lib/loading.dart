import 'package:flutter/material.dart';

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
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

          ],
        ),
      ),
    );
  }
}