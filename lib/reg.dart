import 'dart:convert';
import 'package:fakenews/login%20page.dart';
import 'package:fakenews/login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'Home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add Skills and Talents',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const Register(title: 'Add Skills'),
    );
  }
}

class Register extends StatefulWidget {
  const Register({super.key, required this.title});

  final String title;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController eamilController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController postController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  File? _image;
  final _formKey = GlobalKey<FormState>();

  // Method to pick an image from the gallery or camera
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage2()));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blue,
          elevation: 0.0,
          leadingWidth: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 20.0,
                child: IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage2()));
                  },
                  splashRadius: 1.0,
                  icon: const Icon(Icons.arrow_back, color: Colors.black26, size: 24.0),
                ),
              ),
              Text('Register'),
              const SizedBox(width: 40.0),
            ],
          ),
        ),
        body: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: fnameController,
                    decoration: InputDecoration(
                      labelText: "first Name",
                      prefixIcon: const Icon(Icons.description),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your first name.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: lnameController,
                    decoration: InputDecoration(
                      labelText: "last name",
                      prefixIcon: const Icon(Icons.work),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your last name.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Image picker button
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.camera_alt),
                    label: Text(_image == null ? 'Pick an Image' : 'Image Selected'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                  ),


                  const SizedBox(height: 16),
                  TextFormField(
                    controller: eamilController,
                    decoration: InputDecoration(
                      labelText: "email",
                      prefixIcon: const Icon(Icons.work),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: dobController,
                    decoration: InputDecoration(
                      labelText: "Date of Birth",
                      prefixIcon: const Icon(Icons.work),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your date of birth.";
                      }
                      return null;
                    },
                  ),
      const SizedBox(height: 16),
                  TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: "phone",
                      prefixIcon: const Icon(Icons.work),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your phone number.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: pinController,
                    decoration: InputDecoration(
                      labelText: "pin",
                      prefixIcon: const Icon(Icons.work),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your pin.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: postController,
                    decoration: InputDecoration(
                      labelText: "post",
                      prefixIcon: const Icon(Icons.work),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "post.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: "username",
                      prefixIcon: const Icon(Icons.work),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your username.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: "password",
                      prefixIcon: const Icon(Icons.work),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password.";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() && _image != null) {
                        _Register();
                      } else {
                        Fluttertoast.showToast(msg: 'Please fill in all fields and select an image');
                      }
                    },
                    child: const Text('SignUp'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Method to send data to the backend
  void _Register() async {
    String fname = fnameController.text.trim();
    String lname = lnameController.text.trim();
    String eamil = eamilController.text.trim();
    String dob = dobController.text.trim();
    String phone = phoneController.text.trim();
    String place = placeController.text.trim();

    String pin = pinController.text.trim();
    String post = postController.text.trim();
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();


    SharedPreferences sh = await SharedPreferences.getInstance();
    String? url = sh.getString('url');
    // String? lid = sh.getString('lid');


    if (url == null) {
      Fluttertoast.showToast(msg: 'Invalid configuration. Please try again.');
      return;
    }

    final Uri apiUrl = Uri.parse(url + "/user_register");
    print(apiUrl);
    print('registerrrr=====');

    try {
      // Prepare the request to send the data and the file
      var request = http.MultipartRequest('POST', apiUrl)
        ..fields['fname'] = fname
        ..fields['lname'] = lname
        ..fields['eamil'] = eamil
        ..fields['dob'] = dob
        ..fields['phone'] = phone
        ..fields['place'] = place
        ..fields['pin'] = pin
        ..fields['post'] = post
        ..fields['username'] = username
        ..fields['password'] = password;

      // Attach the image file if it's selected
      if (_image != null) {
        var file = await http.MultipartFile.fromPath('photo', _image!.path);
        request.files.add(file);
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        var data = jsonDecode(responseData);

        if (data['status'] == 'ok') {
          Fluttertoast.showToast(msg: ' Added Successfully');
          fnameController.clear();
          lnameController.clear();
          eamilController.clear();
          dobController.clear();
          phoneController.clear();
          placeController.clear();
          pinController.clear();
          postController.clear();
          usernameController.clear();
          passwordController.clear();
          setState(() {
            _image = null;
          });
          Navigator.pop(context); // Returns to the previous screen
        } else {
          Fluttertoast.showToast(msg: 'Error: Post not added.');
        }
      } else {
        Fluttertoast.showToast(msg: 'Server Error: ${response.statusCode}');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Network Error: ${e.toString()}');
    }
  }
}
