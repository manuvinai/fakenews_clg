// import 'dart:convert';
// import 'package:fakenews/forget_password.dart';
// import 'package:fakenews/reg.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
//
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'home.dart';
//
//
// // Import the UserHome page
//
// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});
//
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   // Function to show an alert dialog
//   void _showAlertDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Login Failed'),
//           content: Text(message),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Colors.pink,
//               Colors.pink,
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: Center(
//             child: ConstrainedBox(
//               constraints: BoxConstraints(
//                 maxWidth: 400,
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   const SizedBox(height: 20),
//                   const SizedBox(height: 200),
//                   Text(
//                     'Welcome Back!',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(height: 40),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: TextField(
//                       controller: usernameController,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                           borderSide: BorderSide(color: Colors.blue),
//                         ),
//                         labelText: 'Username',
//                         hintText: 'Enter your username',
//                         prefixIcon: Icon(Icons.person, color: Colors.white),
//                         labelStyle: TextStyle(color: Colors.white),
//                         hintStyle: TextStyle(color: Colors.white54),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: TextField(
//                       controller: passwordController,
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                           borderSide: BorderSide(color: Colors.blue),
//                         ),
//                         labelText: 'Password',
//                         hintText: 'Enter your password',
//                         prefixIcon: Icon(Icons.lock, color: Colors.white),
//                         labelStyle: TextStyle(color: Colors.white),
//                         hintStyle: TextStyle(color: Colors.white54),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.white,
//                         backgroundColor: Colors.pink,
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 20.0, vertical: 15.0),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         elevation: 5,
//                       ),
//                       onPressed: () async {
//                         final sh = await SharedPreferences.getInstance();
//                         try {
//
//                           String Uname = usernameController.text.toString();
//                           String Passwd = passwordController.text.toString();
//                           String url = sh.getString("url").toString();
//
//                           var data = await http.post(
//                             Uri.parse(url + "/android_login"),
//                             body: {
//                               'username': Uname,
//                               'password': Passwd,
//                             },
//                           );
//                           var jasondata = json.decode(data.body);
//                           String status = jasondata['status'].toString();
//                           String type = jasondata['type'].toString();
//
//                           if (status == "ok") {
//                             String lid = jasondata['lid'].toString();
//                             sh.setString("lid", lid);
//
//                             if (type == 'user') {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => HomePage(),
//                                 ),
//                               );
//                             }
//
//
//                           } else {
//                             _showAlertDialog(
//                                 "Username or password does not exist.");
//                           }
//                         }
//                         catch(e){
//                           // print(e.toString());
//                           Fluttertoast.showToast(msg: "--------------"+e.toString());
//                         }
//                       },
//                       child: const Text("Login"),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text("Don't have an account? ",
//                           style: TextStyle(color: Colors.white)),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => Register(title: '',),
//                             ),
//                           );
//                         },
//                         child: const Text(
//                           'Register',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => Forget(),
//                             ),
//                           );
//                         },
//                         child: const Text(
//                           'forgot password ?',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
