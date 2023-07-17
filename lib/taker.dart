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
          title: const Text('Quiz'),
        ),
        body: QuizScreen(randomQuiz: randomQuiz),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget{
  final dynamic randomQuiz;

  const QuizScreen({super.key, required this.randomQuiz});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>{
  dynamic wrongQuestions;
  int currentIndex = 0;
  int correctAnswer = 0;
  String? selectedOption;
  String? filledAnswer;

  Widget buildQuestion(){
    final currentQuestion = widget.randomQuiz[currentIndex];

    if(currentQuestion is MulChoice){
      return Column(
        children: [
          Text(
            currentQuestion.stem,
            style: const TextStyle(fontSize: 16)
          ),
          const SizedBox(height: 16),
          Column(
            children: (currentQuestion.options).map((option) {
              return CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(option),
                value: option == selectedOption,
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      if (currentQuestion.checkAnswer(value)) {
                        correctAnswer++; // Increase the count of correct answers
                      } else {
                        if(correctAnswer > 0){
                          correctAnswer--;
                        } // Decrease the count of correct answers
                      }
                      selectedOption = option;
                    } else {
                      selectedOption = null;
                    }
                  });
                },
              );
            }).toList(),
          ),
        ],
      );
    } else if(currentQuestion is FillIn){
      return Column(
        children: [
          Text(
            currentQuestion.stem,
            style: const TextStyle(fontSize: 16.0),
          ),
          const SizedBox(height: 16.0),
          TextField(
            onChanged: (value) {
              filledAnswer = value;
              if (currentQuestion.checkAnswer(value)) {
                correctAnswer++; // Increase the count of correct answers
              } else {
                if(correctAnswer > 0){
                  correctAnswer--;
                }// Decrease the count of correct answers
              }
            },
            decoration: const InputDecoration(
              hintText: 'Answer',
            ),
          ),
        ],
      );
    } else {
      return const Text('Question display error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Question ${currentIndex + 1}',
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          buildQuestion(),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (currentIndex > 0)
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      currentIndex--;
                    });
                  },
                  child: const Text('Previous'),
                ),
              if (currentIndex < widget.randomQuiz.length - 1)
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      currentIndex++;
                    });
                  },
                  child: const Text('Next'),
                ),
              if (currentIndex == widget.randomQuiz.length - 1)
                ElevatedButton(
                  onPressed: () {
                    double grade = (correctAnswer / widget.randomQuiz.length) * 100;
                  },
                  child: const Text('End Quiz'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}