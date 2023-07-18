import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';

class Review extends StatelessWidget{
  final dynamic wrongQuestions;

  const Review(this.wrongQuestions, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text('Grade'),
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
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          TextHighlight(
              text: currentQuestion.answer,
              words: currentQuestion.answer,
          ),
        ],
      ),
    );
  }

}