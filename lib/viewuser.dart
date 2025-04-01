import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ViewUsersPage extends StatefulWidget {
  @override
  _ViewUsersPageState createState() => _ViewUsersPageState();
}

class _ViewUsersPageState extends State<ViewUsersPage> {
  bool _isLoading = false;
  List<dynamic> users = [];
  String purl = "";

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lid = prefs.getString('lid'); // Get the logged-in user ID (lid)
    String? url = prefs.getString('url'); // Get the base URL for the API
    purl = url.toString();
    if (lid == null || url == null) {
      Fluttertoast.showToast(msg: 'User ID or URL not found.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(url + '/view_users'), // Replace with the correct URL endpoint
        body: {
          'lid': lid,

          // Send the logged-in user ID to the server
        },
      );

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          setState(() {
            users = data['data']; // Store the user data in the users list
          });
        } else {
          Fluttertoast.showToast(msg: 'Failed to load users.');
        }
      } else {
        Fluttertoast.showToast(msg: 'Error: Failed to load users.');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(msg: 'Error: $e');
    }
  }

  Future<void> _sendRequest(String toUserId) async {
    Fluttertoast.showToast(msg: "Preparing to send request...");
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? fromUserId = prefs.getString('lid'); // Get logged-in user ID
      String? url = prefs.getString('url'); // Get the base URL for the API

      if (fromUserId == null || url == null) {
        Fluttertoast.showToast(msg: 'User ID or URL not found.');
        return;
      }

      final response = await http.post(
        Uri.parse(url + '/send_request'), // Backend endpoint for sending a request
        body: {
          'lid': fromUserId, // The logged-in user ID
          'to_user_id': toUserId,
        },
      );

      // Check the response and log the body for debugging
      print("Response: ${response.body}");

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          Fluttertoast.showToast(msg: 'Request sent successfully.');
        } else {
          Fluttertoast.showToast(msg: 'request send only once.');
        }
      } else {
        Fluttertoast.showToast(msg: 'Error: Failed to send request. Status code: ${response.statusCode}');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Users"),
        backgroundColor: Colors.deepPurple,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : users.isEmpty
          ? Center(child: Text("No users found."))
          : ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          var user = users[index];
          print(user);
          print(purl + user['image']);

          return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: user['image'] != null
                                  ? NetworkImage(purl + user['image'])
                                  : AssetImage('assets/default_avatar.png')
                              as ImageProvider,
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${user['fname']} ${user['lname']}',
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Text(user['email']),
                                Text(user['phonenumber'].toString()),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        // Text(
                        //   'Gender: ${user['gender']}',
                        //   style: TextStyle(fontSize: 16),
                        // ),
                        // Text(
                        //   'Date of Birth: ${user['dob']}',
                        //   style: TextStyle(fontSize: 16),
                        // ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send, color: Colors.deepPurple),
                    onPressed: () => _sendRequest(user['id'].toString()), // Send request to user
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
