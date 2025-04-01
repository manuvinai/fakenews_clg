import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fakenews/forget_password.dart';
import 'package:fakenews/reg.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import 'newui.dart';
void main() {
  runApp(Login());
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Colors.blueAccent,
       // accentColor: Colors.orange,
        bottomAppBarColor: Colors.white,
      ),
      home: LoginPage2(),
    );
  }
}

class LoginPage2 extends StatefulWidget {
  @override
  _LoginPage2State createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  void _showAlertDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Login Failed'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please fill in both fields."),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Logging in with username: $username"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.blue,  // Use the primary color from the theme
      ),
      backgroundColor: Colors.white,

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 200,),
              Icon(
                Icons.account_circle,
                size: 100,
                color: Colors.blue,  // Use primary color for the icon
              ),
              SizedBox(height: 20),

              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              ElevatedButton(
                onPressed: ()async{
                  final sh = await SharedPreferences.getInstance();
                  try {

                    String Uname = _usernameController.text.toString();
                    String Passwd = _passwordController.text.toString();
                    String url = sh.getString("url").toString();

                    var data = await http.post(
                      Uri.parse(url + "/android_login"),
                      body: {
                        'username': Uname,
                        'password': Passwd,
                      },
                    );
                    var jasondata = json.decode(data.body);
                    String status = jasondata['status'].toString();
                    String type = jasondata['type'].toString();

                    if (status == "ok") {
                      String lid = jasondata['lid'].toString();
                      sh.setString("lid", lid);

                      if (type == 'user') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeNewPage(title: '',),
                          ),
                        );
                      }


                    } else {
                      _showAlertDialog(
                          "Username or password does not exist.");
                    }
                  }
                  catch(e){
                    // print(e.toString());
                    Fluttertoast.showToast(msg: "--------------"+e.toString());
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,  // Use primary color for the button
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 3,
                ),
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              SizedBox(height: 16),

              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Forget(),));


                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Forgot Password action"),
                  ));
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(color: Theme.of(context).primaryColorLight), // Use accent color for forgot password text
                ),
              ),
              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? "),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Register(title: '',),));
                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //   content: Text("Signup action"),
                      // ));
                    },
                    child: Text('Sign Up', style: TextStyle(color: Theme.of(context).primaryColorLight)),  // Use accent color for sign-up text
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
