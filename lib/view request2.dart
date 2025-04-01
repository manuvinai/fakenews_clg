import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class
ViewRequest2 extends StatefulWidget {
  @override
  _ViewRequest2State createState() => _ViewRequest2State();
}

class _ViewRequest2State extends State<ViewRequest2> {
  bool _isLoading = false;
  List<dynamic> requests = [];
  String purl = "";

  @override
  void initState() {
    super.initState();
    _fetchFriendRequests(); // Fetch the friend requests when the page is initialized
  }

  // Fetch pending friend requests from the backend
  Future<void> _fetchFriendRequests() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lid = prefs.getString('lid'); // Get the logged-in user ID
    String? url = prefs.getString('url'); // Get the base URL for the API
    print(url);
    print('=======================url');
    print(url);
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
        Uri.parse(url + '/user_view_own_friend_request'), // Backend endpoint for friend requests
        body: {'lid': lid}, // Send the logged-in user ID
      );

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        // Check if 'data' exists in the response and is a List
        if (data['data'] != null && data['data'] is List) {
          setState(() {
            requests = data['data']; // Store the list of friend requests
          });
        } else {
          Fluttertoast.showToast(msg: 'No friend requests found.');
        }
      } else {
        Fluttertoast.showToast(msg: 'Error: Failed to load friend requests.');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(msg: 'Error: $e');
    }
  }

  // Future<void> _acceptFriendRequest(String tid) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? url = prefs.getString('url').toString();
  //
  //   setState(() {
  //     _isLoading = true;
  //   });
  //
  //   try {
  //     final response = await http.post(
  //       Uri.parse(url + '/and_accept_friendrequest'),
  //       body: {'tid': tid},
  //     );
  //
  //     setState(() {
  //       _isLoading = false;
  //     });
  //
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body);
  //       if (data['status'] == 'ok') {
  //         Fluttertoast.showToast(msg: 'Friend request accepted.');
  //         // Update the request status in the UI
  //         setState(() {
  //           requests.firstWhere((request) => request['tid'] == tid)['status'] = 'accepted';
  //         });
  //       } else {
  //         Fluttertoast.showToast(msg: 'Failed to accept friend request.');
  //       }
  //     } else {
  //       Fluttertoast.showToast(msg: 'Error: Failed to accept friend request.');
  //     }
  //   } catch (e) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     Fluttertoast.showToast(msg: 'Error: $e');
  //   }
  // }

  // Future<void> _acceptFriendRequest(String tid) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? url = prefs.getString('url');
  //   // String? lid = prefs.getString('lid');
  //
  //   // Check if url or lid is null
  //   if (url == null) {
  //     Fluttertoast.showToast(msg: 'User ID or URL not found.');
  //     return;
  //   }
  //
  //   print(url);
  //   print('accept==========');
  //
  //   setState(() {
  //     _isLoading = true;
  //   });
  //
  //   try {
  //     final response = await http.post(
  //       Uri.parse(url + '/and_accept_friendrequest'),
  //       body: {'tid': tid},  // Pass lid as well if needed in the backend
  //     );
  //
  //     setState(() {
  //       _isLoading = false;
  //     });
  //
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body);
  //       if (data['status'] == 'ok') {
  //         Fluttertoast.showToast(msg: 'Friend request accepted.');
  //
  //         // Update the request status in the UI
  //         setState(() {
  //           var request = requests.firstWhere(
  //                 (request) => request['tid'] == tid,
  //             orElse: () => null,
  //           );
  //           if (request != null) {
  //             request['status'] = 'accepted'; // Update the status
  //           }
  //         });
  //       } else {
  //         Fluttertoast.showToast(msg: 'Failed to accept friend request.');
  //       }
  //     } else {
  //       Fluttertoast.showToast(msg: 'Error: Failed to accept friend request.');
  //     }
  //   } catch (e) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     Fluttertoast.showToast(msg: 'Error: $e');
  //   }
  // }




  Future<void> _acceptFriendRequest(String tid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? url = prefs.getString('url');

    // Check if URL is null
    if (url == null) {
      Fluttertoast.showToast(msg: 'URL not found.');
      return;
    }

    // Logging the tid
    print('Attempting to accept request with tid: $tid');
    print('Request URL: ${url + '/and_accept_friendrequest'}');

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(url + '/and_accept_friendrequest'),
        body: {'tid': tid.toString()},  // Ensure tid is sent as a string
      );

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print('Response data: $data');

        if (data['status'] == 'ok') {
          Fluttertoast.showToast(msg: 'Friend request accepted.');

          // Update the request status in the UI
          setState(() {
            var request = requests.firstWhere(
                  (request) => request['tid'] == tid,
              orElse: () => null,
            );
            if (request != null) {
              request['status'] = 'accepted';  // Update the status
            }
          });
        } else {
          Fluttertoast.showToast(msg: 'Failed to accept friend request.');
        }
      } else {
        Fluttertoast.showToast(msg: 'Error: Failed to accept friend request. Status: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(msg: 'Error: $e');
      print('Error: $e');  // Log the error for debugging
    }
  }



  // Reject friend request
  Future<void> _rejectFriendRequest(String tid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? url = prefs.getString('url').toString();

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(url + '/and_reject_friendrequest'),
        body: {'tid': tid},
      );

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == 'ok') {
          Fluttertoast.showToast(msg: 'Friend request rejected.');
          // Update the request status in the UI
          setState(() {
            requests.firstWhere((request) => request['tid'] == tid)['status'] = 'rejected';
          });
        } else {
          Fluttertoast.showToast(msg: 'Failed to reject friend request.');
        }
      } else {
        Fluttertoast.showToast(msg: 'Error: Failed to reject friend request.');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(msg: 'Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Friend Requests"),
        backgroundColor: Colors.deepPurple,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator when fetching requests
          : requests.isEmpty
          ? Center(child: Text("No friend requests found.")) // Show message if no requests
          : ListView.builder(
        itemCount: requests.length, // Number of friend requests
        itemBuilder: (context, index) {
          var request = requests[index];

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
                              backgroundImage: request['photo'] != null
                                  ? NetworkImage(purl + request['photo'])
                                  : AssetImage('assets/default_avatar.png') as ImageProvider,
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  request['FROM_id'],
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Text(request['email']), // Email or other info
                                // Text(request['id']), // Email or other info
                                SizedBox(height: 5),
                                // Text(
                                //   request['status'] ?? 'pending',
                                //   style: TextStyle(
                                //     fontSize: 14,
                                //     color: request['status'] == 'accepted'
                                //         ? Colors.green
                                //         : request['status'] == 'rejected'
                                //         ? Colors.red
                                //         : Colors.grey,
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Only show accept/reject buttons if the request is pending
                  if (request['status'] == null || request['status'] == 'pending')
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.check, color: Colors.green),
                          onPressed: () {
                            _acceptFriendRequest(request['id']);
                            print('hitttttttttttttttt');
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.red),
                          onPressed: () {
                            _rejectFriendRequest(request['id']);
                          },
                        ),
                      ],
                    ),
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     // Retrieve necessary shared preferences
                  //     final SharedPreferences prefs = await SharedPreferences.getInstance();
                  //     String? url = prefs.getString('url');
                  //     String? tid = request['id'];  // Assuming `request` is the current request object.
                  //     print(tid);
                  //     print(url);
                  //     print('==============');
                  //
                  //     // Check if URL is valid
                  //     if (url == null) {
                  //       Fluttertoast.showToast(msg: 'URL not found.');
                  //       return;
                  //     }
                  //
                  //     print(url);
                  //     print('accept==========');
                  //
                  //     setState(() {
                  //       _isLoading = true;
                  //     });
                  //
                  //     try {
                  //       final response = await http.post(
                  //         Uri.parse(url + 'and_accept_friendrequest'),
                  //         body: {'tid': tid},  // Pass tid to the backend
                  //       );
                  //
                  //       setState(() {
                  //         _isLoading = false;
                  //       });
                  //
                  //       if (response.statusCode == 200) {
                  //         var data = jsonDecode(response.body);
                  //         if (data['status'] == 'ok') {
                  //           Fluttertoast.showToast(msg: 'Friend request accepted.');
                  //
                  //           // Update the request status in the UI
                  //           setState(() {
                  //             var request = requests.firstWhere(
                  //                   (request) => request['tid'] == tid,
                  //               orElse: () => null,
                  //             );
                  //             if (request != null) {
                  //               request['status'] = 'accepted'; // Update the status
                  //             }
                  //           });
                  //         } else {
                  //           Fluttertoast.showToast(msg: 'Failed to accept friend request.');
                  //         }
                  //       } else {
                  //         Fluttertoast.showToast(msg: 'Error: Failed to accept friend request.');
                  //       }
                  //     } catch (e) {
                  //       setState(() {
                  //         _isLoading = false;
                  //       });
                  //       Fluttertoast.showToast(msg: 'Error: $e');
                  //     }
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Colors.green, // Color of the accept button
                  //   ),
                  //   child: Icon(
                  //     Icons.check,
                  //     color: Colors.white, // White icon color for visibility
                  //   ),
                  // ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}




