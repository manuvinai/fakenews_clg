// import 'dart:convert';
//
// import 'package:fakenews/login%20page.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:fakenews/home.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// void main() {
//   runApp(Forget());
// }
//
// class Forget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: EmailInputPage(),
//     );
//   }
// }
//
// class EmailInputPage extends StatefulWidget {
//   @override
//   _EmailInputPageState createState() => _EmailInputPageState();
// }
//
// class _EmailInputPageState extends State<EmailInputPage> {
//   final TextEditingController _emailController = TextEditingController();
//
//
//
//   void _submitEmail() async {
//     String compliant = _emailController.text.toString();
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     // String lid = sh.getString('lid').toString();
//     final urls = Uri.parse(url + "/forgot_password");
//     try {
//       final response = await http.post(urls, body: {
//         'email': compliant,
//         // 'lid': lid,
//       });
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status == 'ok') {
//           Fluttertoast.showToast(msg: 'Please Check your mail');
//
//
//           Navigator.push(context, MaterialPageRoute(
//             builder: (context) => LoginPage2(),));
//         } else {
//           Fluttertoast.showToast(msg: 'Not Found');
//         }
//       }
//       else {
//         Fluttertoast.showToast(msg: 'Network Error');
//       }
//     }
//     catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Email Input')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Please enter your email:',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 16),
//             TextField(
//               controller: _emailController,
//               keyboardType: TextInputType.emailAddress,
//               decoration: InputDecoration(
//                 labelText: 'Email',
//                 border: OutlineInputBorder(),
//                 hintText: 'Enter your email here',
//               ),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _submitEmail,
//               child: Text('sent password'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:fakenews/login%20page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(Forget());
}

class Forget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto', // Add a professional font
      ),
      home: EmailInputPage(),
    );
  }
}

class EmailInputPage extends StatefulWidget {
  @override
  _EmailInputPageState createState() => _EmailInputPageState();
}

class _EmailInputPageState extends State<EmailInputPage> {
  final TextEditingController _emailController = TextEditingController();

  // Method to submit the email for password recovery
  void _submitEmail() async {
    String email = _emailController.text.trim();
    if (email.isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter your email address');
      return;
    }

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url') ?? '';  // Ensure URL is fetched properly
    final uri = Uri.parse('$url/forgot_password');

    try {
      final response = await http.post(uri, body: {'email': email});
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Fluttertoast.showToast(msg: 'Check your email for the new password');
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage2()));
        } else {
          Fluttertoast.showToast(msg: 'Email not found or error occurred');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network error, please try again later');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Clean background
      appBar: AppBar(
        title: Text('Forgot Password'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blueAccent, // Custom AppBar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0), // Padding around the content
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo or Header
            Icon(
              Icons.lock_outline,
              size: 100,
              color: Colors.blueAccent,
            ),
            SizedBox(height: 20),
            Text(
              'Enter your email to reset your password.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),

            // Email input field
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.blueAccent),
                hintText: 'Enter your email address',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Submit button
            ElevatedButton(
              onPressed: _submitEmail,
              child: Text('Send password'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent, // Button color
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Rounded corners
                ),
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Spacer(), // Push the content to the top

            // Footer or back link
            GestureDetector(
              onTap: () {
                Navigator.pop(context);  // Navigate back to the previous screen
              },
              child: Text(
                'Back to Login',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

