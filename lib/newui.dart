
import 'package:fakenews/add_post.dart';
import 'package:fakenews/commend.dart';
import 'package:fakenews/login%20page.dart';
import 'package:fakenews/sent_feedback.dart';
import 'package:fakenews/uihome.dart';
import 'package:fakenews/view%20request2.dart';
import 'package:fakenews/view_complaint.dart';
import 'package:fakenews/view_friends.dart';
import 'package:fakenews/view_my_post.dart';
import 'package:fakenews/view_request.dart';
import 'package:fakenews/viewprofile.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


import 'change password.dart';
import 'change pasword2.dart';
import 'login.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const HomeNew());
}

class HomeNew extends StatelessWidget {
  const HomeNew({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      theme: ThemeData(
        colorScheme:
        ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const HomeNewPage(title: 'Home'),
    );
  }
}

class HomeNewPage extends StatefulWidget {
  const HomeNewPage({super.key, required this.title});

  final String title;

  @override
  State<HomeNewPage> createState() => _HomeNewPageState();
}

class _HomeNewPageState extends State<HomeNewPage> {
  _HomeNewPageState() {
    viewreply();
    _send_data2();
    a();
  }

  List<String> id_ = <String>[];
  List<String> date_time_ = <String>[];

  List<String> USER_ = <String>[];
  List<String> post_ = <String>[];
  List<String> title_ = <String>[];
  List<String> description_ = <String>[];
  List<String> photo_ = <String>[];
  List<String> image_ = <String>[];

  Future<void> viewreply() async {
    List<String> id = <String>[];
    List<String> date_time = <String>[];
    List<String> USER = <String>[];
    List<String> post = <String>[];
    List<String> title = <String>[];
    List<String> description = <String>[];
    List<String> photo = <String>[];
    List<String> image = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String imgurl = sh.getString('imgurl').toString();
      String url = urls + '/view_post';

      var data = await http.post(Uri.parse(url), body: {
        // 'lid': lid (uncomment and include if needed)
      });

      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];
      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        // Handling null values gracefully before adding to lists
        id.add(arr[i]['id']?.toString() ?? '');  // Ensure it doesn't add null
        date_time.add(arr[i]['date_time']?.toString() ?? '');  // Handle null USER
        post.add(arr[i]['post']?.toString() ?? '');  // Handle null title
        photo.add(imgurl + (arr[i]['photo']?.toString() ?? ''));  // Handle null image
        // photo.add(sh.getString('img_url').toString() + (arr[i]['photo']?.toString() ?? ''));  // Handle null image
        image.add(imgurl + (arr[i]['image']?.toString() ?? ''));  // Handle null photo
        USER.add(arr[i]['USER']?.toString() ?? '');  // Handle null date_time
        title.add(arr[i]['title']?.toString() ?? '');  // Handle null liked
        description.add(arr[i]['description']?.toString() ?? '');  // Handle null likes

      }

      setState(() {
        id_ = id;
        date_time_ = date_time;
        photo_ = photo;
        post_ = post;
        USER_ = USER;
        title_ = title;
        description_ = description;
        image_ = image;
      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      // Handle error
    }
  }

  String uname_ = "";
  String email_ = "";
  String uphoto_ = "";

  a() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String name = sh.getString('name').toString();
    String email = sh.getString('email').toString();
    String photo = sh.getString('photo').toString();

    setState(() {
      uname_ = name;
      email_ = email;
      uphoto_ = photo;
    });
  }

  TextEditingController unameController = new TextEditingController();
  TextEditingController passController = new TextEditingController();


  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text('Do you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Add your logout logic here (e.g., clearing user session or navigating)
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage2(),
                    ));                // Here you can navigate to the login screen or perform other logout tasks
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Social Net",
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.logout, color: Colors.black),
              onPressed: () {
                _showLogoutDialog(context); // Show the logout confirmation dialog
              },
            ),
          ],
        ),
        body:
        ListView.builder(

          physics: BouncingScrollPhysics(),
          // padding: EdgeInsets.all(5.0),
          // shrinkWrap: true,
          itemCount: id_.length,
          itemBuilder: (BuildContext context, int index) {
            return


              GestureDetector(
                onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CommentsPage( postId: id_[index].toString(),),
                ),
              );
            },
            child:
            Padding(
                padding: const EdgeInsets.all(0.7),

                child: Card(
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(4),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(image_[index]),
                                ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(0),
                                    child: Text(USER_[index]),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(0),
                                    child: Text(date_time_[index]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Image.network(
                              photo_[index],
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(photo_[index]),
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.all(5),
                          //   child: Row(
                          //     children: [
                          //       IconButton(
                          //         icon: liked_[index] == 'yes'
                          //             ? Icon(
                          //           Icons.thumb_up,
                          //           color: Colors.blue,
                          //         )
                          //             : Icon(
                          //           Icons.thumb_up_alt_outlined,
                          //         ),
                          //         onPressed: () async {
                          //           SharedPreferences sh =
                          //           await SharedPreferences.getInstance();
                          //           String url = sh.getString('url').toString();
                          //           String lid = sh.getString('lid').toString();
                          //
                          //           final urls = Uri.parse('$url/likes/');
                          //           try {
                          //             final response =
                          //             await http.post(urls, body: {
                          //               'lid': lid,
                          //               'pid': id_[index],
                          //             });
                          //             if (response.statusCode == 200) {
                          //               String status =
                          //               jsonDecode(response.body)['status'];
                          //               if (status == 'ok') {
                          //                 viewreply();
                          //               } else {
                          //                 Fluttertoast.showToast(
                          //                     msg: 'Network Error');
                          //               }
                          //             }
                          //           } catch (e) {
                          //             Fluttertoast.showToast(msg: e.toString());
                          //           }
                          //         },
                          //       ),
                          //       Text(likes_[index]),
                          //       IconButton(
                          //         icon: Icon(
                          //           Icons.comment,
                          //         ),
                          //         onPressed: () async {
                          //           SharedPreferences sh =
                          //           await SharedPreferences.getInstance();
                          //           sh.setString("pid", id_[index]);
                          //           // Navigator.push(
                          //           //     context,
                          //           //     MaterialPageRoute(
                          //           //       builder: (context) =>
                          //           //           MyViewCommetPage(
                          //           //               title: 'comments'),
                          //           //     ));
                          //         },
                          //       ),
                          //     ],
                          //   ),
                          // ),

                          // Text(photo_[index])
                        ],
                      ),
                    ],
                  ),
                  elevation: 8,
                  margin: EdgeInsets.all(10),
                )));

          },
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 18, 82, 98),
                ),
                child: Column(children: [
                  CircleAvatar(
                      radius: 29, backgroundImage: NetworkImage(pphoto_)),
                  Text(pname_, style: TextStyle(color: Colors.white)),
                  Text(email_, style: TextStyle(color: Colors.white)),
                ]),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeNew(),
                      ));
                },
              ),
              // ListTile(
              //   leading: Icon(Icons.contact_page_outlined),
              //   title: const Text('  Profile '),
              //   onTap: () {
              //     Navigator.pop(context);
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => Profile(
              //             title: '',
              //           ),
              //         ));
              //   },
              // ),

              ListTile(
                leading: Icon(Icons.password),
                title: const Text(' change password '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyUserChangePassword2(
                        ),
                      ));
                },
              ),

              ListTile(
                leading: Icon(Icons.post_add),
                title: const Text('My Post'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyPostsPage(
                        ),
                      ));
                 },
             ),
              // ListTile(
              //   leading: Icon(Icons.people_alt_outlined),
              //   title: const Text('Search user'),
              //   onTap: () {
              //     Navigator.pop(context);
              //     // Navigator.push(
              //     //     context,
              //     //     MaterialPageRoute(
              //     //       builder: (context) => Myotheruserandsendrequestpage(
              //     //         title: " ",
              //     //       ),
              //     //     ));
              //   },
              // ),
              // ListTile(
              //   leading: Icon(Icons.post_add),
              //   title: const Text('Others post'),
              //   onTap: () {
              //     Navigator.pop(context);
              //     // Navigator.push(
              //     //     context,
              //     //     MaterialPageRoute(
              //     //       builder: (context) => MyviewotherspostPage(
              //     //         title: " Post",
              //     //       ),
              //     //     ));
              //   },
              // ),
              // ListTile(
              //   leading: Icon(Icons.add_alert),
              //   title: const Text('Notification'),
              //   onTap: () {
              //     Navigator.pop(context);
              //     // Navigator.push(
              //     //     context,
              //         // MaterialPageRoute(
              //         //   builder: (context) => Viewnotification(
              //         //     title: "Notification",
              //         //   ),
              //         // ));
              //   },
              // ),

              // ListTile(
              //   leading: Icon(Icons.medical_services_outlined),
              //   title: const Text(' View approved request '),
              //   onTap: () {
              //     Navigator.pop(context);
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => MyApprovedrequestPage(
              //             title: "Test Details",
              //           ),
              //         ));
              //   },
              // ),
              ListTile(
                leading: Icon(Icons.request_page),
                title: const Text('Friend Request'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewRequest2(
                        ),
                      ));
                },
              ),
              ListTile(
                leading: Icon(Icons.list_alt_outlined),
                title: const Text('View friend list'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FriendRequestsPage(),
                      ));
                },
              ),
              // ListTile(
              //   leading: Icon(Icons.shopping_cart_sharp),
              //   title: const Text(' View comment and reply'),
              //   onTap: () {
              //     Navigator.pop(context);
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => MysendcommentandreplyPage(
              //             title: '',
              //           ),
              //         ));
              //   },
              // ),
              // ListTile(
              //   leading: Icon(Icons.feed_outlined),
              //   title: const Text('view comment '),
              //   onTap: () {
              //     Navigator.pop(context);
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => Viewreplypage(
              //             title: "View Complaint",
              //           ),
              //         ));
              //   },
              // ),
              // ListTile(
              //   leading: Icon(Icons.change_circle),
              //   title: const Text(' send complaint  '),
              //   onTap: () {
              //     Navigator.pop(context);
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => UserSendComplaint(
              //             title: "Change Password",
              //           ),
              //         ));
              //   },
              // ),
              ListTile(
                leading: Icon(Icons.comment),
                title: const Text('complaint'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => view_complaint(
                          title: '',
                        ),
                      ));
                },
              ),
              ListTile(
                leading: Icon(Icons.star),
                title: const Text('Review And Rating'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserFeedback(
                          title: 'Review',
                        ),
                      ));
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage2(),//login_new_full
                      ));
                },
              ),
            ],
          ),
        ),

        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeNewPage(title: '',)),
                );
                break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddPostPage()),
                );
                break;
              case 2:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile(title: '',)),
                );
                break;
            }
          },
          items: const <BottomNavigationBarItem>[

            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Post',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black,
        ),

      ),
    );
  }

  void _send_data() async {
    String uname = unameController.text;
    String password = passController.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();

    final urls = Uri.parse('$url/myapp/user_loginpost/');
    try {
      final response = await http.post(urls, body: {
        'name': uname,
        'password': password,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          String lid = jsonDecode(response.body)['lid'].toString();
          sh.setString("lid", lid);
          // Navigator.push(context, MaterialPageRoute(
          //   builder: (context) => MyHomePage(title: "Home"),));
        } else {
          // Fluttertoast.showToast(msg: 'Not Found');
        }
      } else {
        // Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      // Fluttertoast.showToast(msg: e.toString());
    }
  }

  String pname_ = "";
  String dob_ = "";
  String gender_ = "";
  String pemail_ = "";
  String phone_ = "";
  String place_ = "";
  String ppost_ = "";
  String pin_ = "";
  String pphoto_ = "";

  void _send_data2() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/view_profile');
    try {
      final response = await http.post(urls, body: {'lid': lid});
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          String pname = jsonDecode(response.body)['name'];
          String dob = jsonDecode(response.body)['dob'].toString();
          String gender = jsonDecode(response.body)['gender'];
          String email = jsonDecode(response.body)['email'];
          String phone = jsonDecode(response.body)['phone'].toString();
          String place = jsonDecode(response.body)['place'];
          String ppost = jsonDecode(response.body)['post'];
          String pin = jsonDecode(response.body)['pin'].toString();
          String pimage = sh.getString("img_url").toString() +
              jsonDecode(response.body)['image'];

          setState(() {
            pname_ = pname;
            dob_ = dob;
            gender_ = gender;
            email_ = email;
            phone_ = phone;
            place_ = place;
            ppost_ = ppost;
            pin_ = pin;
            pphoto_ = pimage;
          });
        } else {
          // Fluttertoast.showToast(msg: 'Not Found');
        }
      } else {
        // Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      // Fluttertoast.showToast(msg: e.toString());
    }
  }
}
