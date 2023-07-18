import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {

    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.0),
          SizedBox(height: 16),

        ],
      ),
    );
  }

}