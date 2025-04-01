import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animate_do/animate_do.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import 'login page.dart';
import 'login.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFF203F81),
        scaffoldBackgroundColor: Colors.grey.shade100,
        fontFamily: 'Roboto',
      ),
      home: IpHome(),
    );
  }
}

class IpHome extends StatefulWidget {
  IpHome({Key? key}) : super(key: key);

  @override
  State<IpHome> createState() => _IpHomeState();
}

class _IpHomeState extends State<IpHome> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controllerIpAddress = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent back navigation
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("IP Address Setup"),
          backgroundColor: Colors.red, // Set your desired background color
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 80),
                FadeInUp(
                  duration: const Duration(milliseconds: 1000),
                  child: const Text(
                    "Fake News",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                FadeInUp(
                  duration: const Duration(milliseconds: 1200),
                  child: const Text(
                    "Enter the IP address below",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 50),
                Expanded(
                  child: FadeInUp(
                    duration: const Duration(milliseconds: 1500),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              "Server IP",
                              style: TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: _controllerIpAddress,
                              decoration: InputDecoration(
                                hintText: "Enter IP Address",
                                prefixIcon: const Icon(Icons.language, color: Colors.grey),
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.grey.shade200),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(color: Color(0xFF203F81)),
                                ),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter a valid IP address";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 40),
                            MaterialButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  sendData();
                                }
                              },
                              height: 50,
                              color: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Center(
                                child: Text(
                                  "Connect",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controllerIpAddress.dispose();
    super.dispose();
  }

  void sendData() async {
    String ip = _controllerIpAddress.text.toString();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('ip', ip);
    prefs.setString('url', 'http://$ip:8000');
    prefs.setString('imgurl', 'http://$ip:8000');
    prefs.setString('imgurl2', 'http://$ip:8000');
     Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage2()));
  }
}
