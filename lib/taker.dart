import 'dart:ffi';

import 'package:quiz_me/question.dart';
import 'package:flutter/material.dart';
import 'package:quiz_me/mulchoice.dart';
import 'package:quiz_me/fillin.dart';
import 'package:quiz_me/gradedquiz.dart';


class Taker extends StatelessWidget{
  final dynamic randomQuiz;

  const Taker(this.randomQuiz, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text('Quiz'),
      ),
      body: QuizScreen(randomQuiz: randomQuiz),
    );
  }
}

class QuizScreen extends StatefulWidget{
  final dynamic randomQuiz;

  const QuizScreen({super.key, required this.randomQuiz});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentIndex = 0;
  int correctAnswers = 0;
  String? selectedOption;
  List<Question> wrongQuestions = [];

  Widget buildQuestion() {
    final currentQuestion = widget.randomQuiz[currentIndex];

    List<bool> selectedOptions = [];

    @override
    void initState() {
      super.initState();
      // Initialize the selectedOptions list with false values for each option
      selectedOptions = List<bool>.filled(currentQuestion.options.length, false);
    }

    if (currentQuestion is MulChoice) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(currentQuestion.stem),
          ListView.builder(
            itemCount: currentQuestion.options.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                title: Text(currentQuestion.options[index]),
                value: selectedOptions[index],
                onChanged: (value) {
                  setState(() {
                    selectedOptions[index] = value!;
                  });
                },
              );
            },
          )
        ],
      );
    } else if (currentQuestion is FillIn) {
      return Column(
        children: [
          Text(
            currentQuestion.stem,
            style: const TextStyle(fontSize: 16.0),
          ),
          const SizedBox(height: 16.0),
          TextField(
            onChanged: (value) {
              setState(() {
                selectedOption = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Answer',
              filled: true,
              fillColor: Colors.grey[200],
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
                    print('$correctAnswers');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GradedQuiz(correctAnswers, wrongQuestions),
                      ),
                    );
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
