import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPostPage extends StatefulWidget {
  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final TextEditingController postController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  XFile? _image;
  final _formKey = GlobalKey<FormState>();

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedImage;
    });
  }

  // Function to send the post to the server
  // Future<void> _sendPost() async {
  //   if (_formKey.currentState!.validate()) {
  //     String post = postController.text.trim();
  //     String title = titleController.text.trim();
  //     String description = descriptionController.text.trim();
  //
  //     if (_image == null) {
  //       Fluttertoast.showToast(msg: 'Please pick an image.');
  //       return;
  //     }
  //
  //     // Get the 'lid' value from SharedPreferences
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String? lid = prefs.getString('lid').toString();
  //
  //     if (lid == null) {
  //       Fluttertoast.showToast(msg: 'User ID not found.');
  //       return;
  //     }
  //
  //     SharedPreferences sh = await SharedPreferences.getInstance();
  //     String url = sh.getString('url').toString();
  //     // String hid = sh.getString('hid').toString();
  //
  //     final urls = Uri.parse(url + "/add_post");
  //
  //     // Prepare the data for sending
  //     var request = http.MultipartRequest('POST', urls);
  //     request.fields['lid'] = lid;
  //     request.fields['post'] = post;
  //     request.fields['title'] = title;
  //     request.fields['description'] = description;
  //
  //     // Add the image as a file to the request
  //     request.files.add(await http.MultipartFile.fromPath('photo', _image!.path));
  //
  //     // Send the request
  //     try {
  //       var response = await request.send();
  //       if (response.statusCode == 200) {
  //         final responseData = jsonDecode(response.body);
  //         String status = responseData['status'];
  //
  //
  //         if (status == 'ok') {
  //           Fluttertoast.showToast(msg: 'Post added successfully');
  //           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddPostPage()));
  //         } else {
  //           Fluttertoast.showToast(msg: '');
  //         }
  //       } else {
  //         Fluttertoast.showToast(msg: 'Failed to add post.');
  //       }
  //     } catch (e) {
  //       Fluttertoast.showToast(msg: 'Error: ${e.toString()}');
  //     }
  //   }
  // }





  Future<void> _sendPost() async {
    if (_formKey.currentState!.validate()) {
      String post = postController.text.trim();
      String title = titleController.text.trim();
      String description = descriptionController.text.trim();

      if (_image == null) {
        Fluttertoast.showToast(msg: 'Please pick an image.');
        return;
      }

      // Get the 'lid' value from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? lid = prefs.getString('lid');

      if (lid == null) {
        Fluttertoast.showToast(msg: 'User ID not found.');
        return;
      }

      SharedPreferences sh = await SharedPreferences.getInstance();
      String? url = sh.getString('url');

      if (url == null) {
        Fluttertoast.showToast(msg: 'URL not found.');
        return;
      }

      final urls = Uri.parse(url + "/add_post");

      // Prepare the data for sending
      var request = http.MultipartRequest('POST', urls);
      request.fields['lid'] = lid;
      request.fields['post'] = post;
      request.fields['title'] = title;
      request.fields['description'] = description;

      // Add the image as a file to the request
      request.files.add(await http.MultipartFile.fromPath('photo', _image!.path));

      // Send the request
      try {
        var response = await request.send();
        if (response.statusCode == 200) {
          // Read the response body as string
          String responseBody = await response.stream.bytesToString();

          // Parse the JSON response
          final responseData = jsonDecode(responseBody);
          String status = responseData['status'];

          if (status == 'ok') {
            Fluttertoast.showToast(msg: 'Post added successfully');
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddPostPage()));
          } else {
            Fluttertoast.showToast(msg: 'Fake news found.');
          }
        } else {
          Fluttertoast.showToast(msg: 'Failed to add post.');
        }
      } catch (e) {
        Fluttertoast.showToast(msg: 'Error: ${e.toString()}');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: postController,
                  decoration: InputDecoration(
                    labelText: 'Post Content',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter post content';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Pick Image'),
                ),
                SizedBox(height: 16),
                if (_image != null) Text("Image Selected: ${_image!.name}"),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _sendPost,
                  child: Text('Add Post'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
