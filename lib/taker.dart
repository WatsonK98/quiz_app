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
  List<Question> wrongQuestions = [];

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.randomQuiz[currentIndex];

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
          Text(
              currentQuestion.stem,
              style: const TextStyle(fontSize: 18.0)
          ),
          if(currentQuestion is MulChoice)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List<Widget>.generate(currentQuestion.options.length, (index) {
                final option = currentQuestion.options[index];
                return ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: Radio<int>(
                    value: index,
                    groupValue: currentQuestion.selectedOptionIndex,
                    onChanged: (int? value) {
                      setState(() {
                        currentQuestion.selectedOptionIndex = value!;
                      });
                    },
                  ),
                  title: Text(option),
                );
              }),
            ),
          if(currentQuestion is FillIn)
            TextField(
              onChanged: (value){
                setState(() {
                  currentQuestion.filledAnswer = value;
                });
              },
              decoration: const InputDecoration(
              labelText: 'Answer',
              ),
            ),
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
                      if (currentQuestion.checkAnswer()) {
                        correctAnswers++;
                      } else if (!wrongQuestions.contains(currentQuestion) && currentQuestion.checkAnswer() == false) {
                        if(correctAnswers > 0){
                          correctAnswers--;
                        }
                        wrongQuestions.add(currentQuestion);
                      }
                      currentIndex++;
                    });
                  },
                  child: const Text('Next'),
                ),
              if (currentIndex == widget.randomQuiz.length - 1)
                ElevatedButton(
                  onPressed: () {
                    if (currentQuestion.checkAnswer()) {
                      correctAnswers++;
                    } else if (!wrongQuestions.contains(currentQuestion) && currentQuestion.checkAnswer() == false) {
                      if(correctAnswers > 0){
                        correctAnswers--;
                      }
                      wrongQuestions.add(currentQuestion);
                    }
                    double grade = (correctAnswers / widget.randomQuiz.length) * 100;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GradedQuiz(grade, wrongQuestions),
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
