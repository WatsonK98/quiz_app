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
  int correctAnswer = 0;
  bool isChecked = false;
  String filledAnswer = '';
  List<dynamic> wrongQuestions = [];

  Widget buildQuestion() {
    final currentQuestion = widget.randomQuiz[currentIndex];

    if (currentQuestion is MulChoice) {
      return Column(
        children: [
          Text(
            currentQuestion.stem,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          Column(
            children: currentQuestion.options.map((option) {
              return CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(option),
                value: isChecked && option == filledAnswer,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value ?? false;
                    if (isChecked) {
                      filledAnswer = option;
                      if (currentQuestion.checkAnswer(option)) {
                        wrongQuestions.remove(currentQuestion);
                        correctAnswer++; // Increase the count of correct answers
                      } else {
                        if (!wrongQuestions.contains(currentQuestion)) {
                          wrongQuestions.add(currentQuestion);
                        }
                      }
                    } else {
                      filledAnswer = '';
                      if (currentQuestion.checkAnswer(option)) {
                        correctAnswer--; // Decrease the count of correct answers
                      }
                    }
                  });
                },
              );
            }).toList(),
          ),
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
                filledAnswer = value;
                if (currentQuestion.checkAnswer(value)) {
                  wrongQuestions.remove(currentQuestion);
                  correctAnswer++; // Increase the count of correct answers
                } else {
                  if (!wrongQuestions.contains(currentQuestion)) {
                    wrongQuestions.add(currentQuestion);
                  }
                }
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
                    print('$correctAnswer');
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
