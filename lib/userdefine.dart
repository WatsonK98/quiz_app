import 'package:flutter/material.dart';
import 'package:quiz_me/loading.dart';

class Userdefine extends StatelessWidget{
  final dynamic values;
  final dynamic finalQuiz;

  const Userdefine(this.values, this.finalQuiz, {super.key});

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
        body: Define(values, finalQuiz),
      ),
    );
  }
}

class Define extends StatefulWidget{
  final dynamic values;
  final dynamic finalQuiz;

  const Define(this.values, this.finalQuiz, {super.key});

  @override
  State<Define> createState() => _Define();
}

class _Define extends State<Define>{

  final GlobalKey<FormFieldState<String>> _userFormFieldKey = GlobalKey();

  get value => {
    'user': _userFormFieldKey.currentState?.value
  };

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Enter desired Number of Questions',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const Text(
              '1-15 [default: 10]',
            ),
            TextFormField(
              key: _userFormFieldKey,
              decoration:  const InputDecoration(
                labelText: 'Desired Questions:',
              ),
            ),
            Builder(builder: (context){
              return Center(
                child: ElevatedButton(
                  onPressed: () {
                    int userVariable = int.parse(value['user']);
                    if(userVariable > 0 && userVariable < 15){
                      var userQuiz = finalQuiz.generateQuiz(userVariable);
                    } else {
                      var defaultQuiz = finalQuiz.generateQuiz(10);
                    }
                  },
                  child: const Text('Accept'),
                ),
              );
            }),
          ],
        )
    );
  }
}