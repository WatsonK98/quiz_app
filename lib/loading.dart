import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

class LoadingQuizzes extends StatefulWidget{
  const LoadingQuizzes({super.key});

  @override
  _LoadingQuizzes createState() => _LoadingQuizzes();
}

class _LoadingQuizzes extends State<LoadingQuizzes>{

  Future fetchResponses() async {}


  @override
  Widget build(BuildContext context){
    return FutureBuilder(
        future: fetchResponses(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          var response = snapshot.data!;
          return Text('$response');
        },
    );
  }

  Future validateLogin(var username, var password) async{
    var url = 'https://www.cs.utep.edu/cheon/cs4381/homework/quiz/login.php?user=$username&pin=$password';
    var response = await http.get(Uri.parse(url));
    var decoded = json.decode(response.body);
    return Future.delayed(const Duration(milliseconds: 50), () => decoded);
  }
}