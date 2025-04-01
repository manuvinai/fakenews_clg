import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CommentsPage extends StatefulWidget {
  final String postId;

  CommentsPage({required this.postId});

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  List<dynamic> comments = [];
  TextEditingController commentController = TextEditingController();
  String baseUrl = "http://your-django-server.com"; // Replace with your server URL

  @override
  void initState() {
    super.initState();
    fetchComments();
  }

  Future<void> fetchComments() async {

    SharedPreferences sh = await SharedPreferences.getInstance();
    baseUrl = sh.getString('url') ?? '';  // Ensure URL is fetched properly

    final response = await http.get(Uri.parse("$baseUrl/comments/${widget.postId}/"));
    if (response.statusCode == 200) {
      setState(() {
        comments = jsonDecode(response.body);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to load comments")));
    }
  }

  Future<void> sendComment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString("lid") ?? ""; // Retrieve logged-in user ID

    if (commentController.text.isNotEmpty) {
      SharedPreferences sh = await SharedPreferences.getInstance();
      baseUrl = sh.getString('url') ?? '';  // Ensure URL is fetched properly

      final response = await http.post(
        Uri.parse("$baseUrl/comments/"),

        body: {
          "post_id": widget.postId,
          "comment": commentController.text,
          "user_id": userId,
          "date_time": DateTime.now().toIso8601String(),
        },
      );

      if (response.statusCode == 200) {
        commentController.clear();
        fetchComments(); // Refresh the list
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to send comment")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Comments")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(child: Icon(Icons.person)),
                  title: Text(comments[index]["comment"]),
                  subtitle: Text(comments[index]["date_time"]),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: commentController,
                    decoration: InputDecoration(
                      hintText: "Write a comment...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
                  onPressed: sendComment,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
