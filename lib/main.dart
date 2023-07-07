import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'loading.dart';

void main() async => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuizAppLogin',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: const Text('Quiz App Login'),
        ),
        body: const QuizAppLogin(),

      ),
    );
  }
}

class QuizAppLogin extends StatefulWidget {
  const QuizAppLogin({super.key});

  @override
  State<QuizAppLogin> createState() => _QuizAppLogin();
}

class _QuizAppLogin extends State<QuizAppLogin> {

  final GlobalKey<FormFieldState<String>> _usernameFormFieldKey = GlobalKey();
  final GlobalKey<FormFieldState<String>> _passwordFormFieldKey = GlobalKey();

  _notEmpty(String value) => value.isNotEmpty;

  get values => {
    'username': _usernameFormFieldKey.currentState?.value,
    'password': _passwordFormFieldKey.currentState?.value
  };

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'CS 5381',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          ),
          const Text(
            'version 1.0.0',
            style: TextStyle(fontSize: 10),
          ),
          TextFormField(
            key: _usernameFormFieldKey,
            decoration: const InputDecoration(
              labelText: 'Username*',
            ),
            validator: (value) =>
            _notEmpty(value!) ? null : 'Username is required',
          ),
          TextFormField(
            key: _passwordFormFieldKey,
            obscureText: true,
            decoration:  const InputDecoration(
              labelText: 'Password**',
            ),
            validator: (value) =>
            _notEmpty(value!) ? null : 'Password is required',
          ),
          Builder(builder: (context){
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: (){
                    if(Form.of(context).validate()){
                      //Validate here
                      var username = values['username'];
                      var password = values['password'];
                      dynamic jsonResponse = validateLogin(username, password);
                      if(jsonResponse['response'] == true){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    loading()));
                      }
                    }
                  },
                  child: const Text('Log In'),
                ),
                TextButton(
                  onPressed: () => Form.of(context).reset(),
                  child: const Text('Reset'),
                ),
              ],
            );
          }),
          const Text(
            '*User name of your primary email address provided by UTEP.',
            style: TextStyle(fontSize: 10),
          ),
          const Text(
            '**Password is the last 4 digits of your Student ID.',
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }

  Future validateLogin(var username, var password) async{
    var url = 'https://www.cs.utep.edu/cheon/cs4381/homework/quiz/login.php?user=$username&pin=$username';
    var response = await http.get(Uri.parse(url));
    var decoded = json.decode(response.body);
    return Future.delayed(const Duration(milliseconds: 50), () => decoded);
  }
}
