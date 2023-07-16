import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loading.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final username = prefs.getString('username') ?? '';
  final password = prefs.getString('password') ?? '';

  HttpOverrides.global = MyHttpOverrides();

  runApp(Login(username: username, password: password));
}

class Login extends StatelessWidget {
  final String username;
  final String password;

  const Login({Key? key, this.username = '', this.password = ''}) : super(key: key);

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
        body: QuizAppLogin(initialUsername: username, initialPassword: password),

      ),
    );
  }
}

class QuizAppLogin extends StatefulWidget {
  final String initialUsername;
  final String initialPassword;

  const QuizAppLogin({Key? key, this.initialUsername = '', this.initialPassword = ''}) : super(key: key);

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

  Future<void> saveCredentials(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('password', password);
  }
  
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
            initialValue: widget.initialUsername,
            validator: (value) =>
            _notEmpty(value!) ? null : 'Username is required',
          ),
          TextFormField(
            key: _passwordFormFieldKey,
            obscureText: true,
            decoration:  const InputDecoration(
              labelText: 'Password**',
            ),
            initialValue: widget.initialPassword,
            validator: (value) =>
            _notEmpty(value!) ? null : 'Password is required',
          ),
          Builder(builder: (context){
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () async {
                    if(Form.of(context).validate()){
                      //Validate here
                      
                      var username = values['username'];
                      var password = values['password'];
                      validateLogin(username, password).then((jsonResponse) {
                        if (jsonResponse['response'] == true) {
                          saveCredentials(username, password);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Loading(values),
                            ),
                          );
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  title: const Text('Login Failed'),
                                  content: const Text('Invalid Username or Password'),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: (){
                                        Navigator.pop(context);
                                        },
                                      child: const Text('Retry'),
                                    ),
                                  ],
                                );
                              }
                          );
                        }
                      });
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

  Future<dynamic> validateLogin(var username, var password) async{
    var url = 'https://www.cs.utep.edu/cheon/cs4381/homework/quiz/login.php?user=$username&pin=$password';
    var response = await http.get(Uri.parse(url));
    var decoded = json.decode(response.body);
    return Future.delayed(const Duration(milliseconds: 50), () => decoded);
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
