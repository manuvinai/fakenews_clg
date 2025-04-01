
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


import 'change password.dart';
import 'change pasword2.dart';
import 'edit_profile.dart';
import 'editprofile2.dart';
import 'home.dart';
import 'newui.dart';



class Profile extends StatefulWidget {
  const Profile({super.key, required this.title});

  final String title;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    senddata();
  }

  String fname = 'fname';
  String lname = 'lname';
  String gender = 'gender';
  String email = 'email';
  String phonenumber = 'phonenumber';
  String image = 'Image';
  String dob = 'dob';


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeNewPage(title: '',
              ),
            ));

        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                height: 280,
                width: double.infinity,
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(16.0, 240.0, 16.0, 16.0),
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => Image.network(image),
                    );
                  },
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.all(16.0),
                            margin: EdgeInsets.only(top: 16.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 110.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            fname,
                                            style: Theme.of(context).textTheme.titleLarge,
                                          ),
                                          SizedBox(
                                            height: 40,
                                          )
                                        ],
                                      ),
                                      Spacer(),
                                      // First CircleAvatar for Edit Profile
                                      CircleAvatar(
                                        backgroundColor: Colors.blueAccent,
                                        child: IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => EditStudProfile(title: '',)),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.edit_outlined,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10), // Add spacing between the two CircleAvatars
                                      // Second CircleAvatar for Change Password
                                      CircleAvatar(
                                        backgroundColor: Colors.blueAccent,
                                        child: IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => MyUserChangePassword2()),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.password,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )

                                // SizedBox(height: 10.0),

                              ],
                            ),
                          ),
                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                image: DecorationImage(
                                    image: NetworkImage(image),
                                    fit: BoxFit.cover)),
                            margin: EdgeInsets.only(left: 20.0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text("Profile Information"),
                            ),
                            Divider(),
                            ListTile(
                              title: Text('name'),
                              subtitle: Text(fname+lname),

                              leading: Icon(Icons.mail_outline),
                            ),
                            ListTile(
                              title: Text('gender'),
                              subtitle: Text(gender),
                              leading: Icon(Icons.mail_outline),
                            ),
                            ListTile(
                              title: Text('Email'),
                              subtitle: Text(email),
                              leading: Icon(Icons.mail_outline),
                            ),
                            ListTile(
                              title: Text("Phone"),
                              subtitle: Text(phonenumber),
                              leading: Icon(Icons.phone),
                            ),
                            ListTile(
                              title: Text("dob"),
                              subtitle: Text(dob),
                              leading: Icon(Icons.phone),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 60,
                left: 20,
                child: MaterialButton(
                  minWidth: 0.2,
                  elevation: 0.2,
                  color: Colors.white,
                  child: const Icon(Icons.arrow_back_ios_outlined,
                      color: Colors.indigo),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeNewPage(title: '',

                          ),
                        ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void senddata() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    final urls = Uri.parse(url + "/view_profile");

    try {
      final response = await http.post(urls, body: {
        'lid': lid,
      });

      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          setState(() {
            email = jsonDecode(response.body)['email'].toString();
            fname = jsonDecode(response.body)['fname'].toString();
            gender = jsonDecode(response.body)['gender'].toString();
            lname = jsonDecode(response.body)['lname'].toString();
            dob = jsonDecode(response.body)['dob'].toString();
            phonenumber = jsonDecode(response.body)['phone'].toString();
            image = sh.getString('url').toString() + jsonDecode(response.body)['Image'];

          });
        } else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

}
