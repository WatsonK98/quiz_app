import 'package:flutter/material.dart';
import 'loading.dart';
import 'taker.dart';

class Userdefine extends StatelessWidget{
  final dynamic finalQuiz;

  const Userdefine(this.finalQuiz, {super.key});

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
        body: Define(finalQuiz),
      ),
    );
  }
}

class Define extends StatefulWidget{
  final dynamic finalQuiz;

  const Define(this.finalQuiz, {super.key});

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
    return Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Form(
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
                const SizedBox(height: 8.0,),
                Builder(builder: (context){
                  return Center(
                    child: ElevatedButton(
                      onPressed: () {
                        int userVariable = int.parse(value['user']);
                        dynamic randomQuiz;
                        if(userVariable > 0 && userVariable < 15){
                          randomQuiz = finalQuiz.generateQuiz(userVariable);
                        } else {
                          randomQuiz = finalQuiz.generateQuiz(10);
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Taker(randomQuiz),
                          ),
                        );
                      },
                      child: const Text('Generate'),
                    ),
                  );
                }),
              ],
          )
        ),
    );
  }
}