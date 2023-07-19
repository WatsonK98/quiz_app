import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';


class Review extends StatelessWidget{
  final dynamic wrongQuestions;

  const Review(this.wrongQuestions, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Review Screen',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: const Text('Review'),
        ),
        body: ReviewScreen(wrongQuestions: wrongQuestions),

      ),
    );
  }
}

class ReviewScreen extends StatefulWidget{
  final dynamic wrongQuestions;

  const ReviewScreen({super.key, required this.wrongQuestions});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen>{
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.wrongQuestions[currentIndex];

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
            style: const TextStyle(fontSize: 16.0)
          ),
          const SizedBox(height: 8.0),
          Text(
            currentQuestion.answer.toString(),
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.green),
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
                    child: const Text('Previous')
                ),
              if (currentIndex < widget.wrongQuestions.length - 1)
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentIndex++;
                      });
                    },
                    child: const Text('Next')
                ),
              if(currentIndex == widget.wrongQuestions.length - 1)
                ElevatedButton(
                    onPressed: () {
                      setState(() async {
                        await Restart.restartApp();
                      });
                    },
                    child: const Text('End Session')
                ),
            ],
          )
        ],
      ),
    );
  }
}