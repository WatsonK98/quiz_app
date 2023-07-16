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
        body: ListView.builder(
          itemCount: randomQuiz.length,
          itemBuilder: (BuildContext context, int index){
            final item = randomQuiz[index];

            if(item is MulChoice){
              return askMulChoice(item);
            } else if (item is FillIn){
              return askFillIn(item);
            }
          },
        ),
      ),
    );
  }

  Widget askMulChoice(MulChoice item){
    return Text('${item.display()}');
  }
  Widget askFillIn(FillIn item){
    return Text('${item.display()}');
  }
}