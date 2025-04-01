// import 'package:fakenews/login%20page.dart';
// import 'package:fakenews/sent_feedback.dart';
// import 'package:fakenews/view%20request2.dart';
// import 'package:fakenews/view_complaint.dart';
// import 'package:fakenews/view_friends.dart';
// import 'package:fakenews/view_request.dart';
// import 'package:fakenews/viewprofile.dart';
// import 'package:fakenews/viewuser.dart';
// import 'package:flutter/material.dart';
// import 'login.dart';
// import 'profile.dart';
//
// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         // Handle back button press with exit confirmation dialog
//         bool shouldExit = await _showExitConfirmationDialog(context);
//         return shouldExit; // Allow or block the exit
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Home Page'),
//           centerTitle: true,
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               // Background Image Section
//               Container(
//                 height: 250,  // Adjust the height as needed
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//
//                       image:
//                       AssetImage('assets/images/sample.jpg'
//                     ),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 child: Align(
//                   alignment: Alignment.bottomLeft,
//                   child: Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Text(
//                       'Welcome to the Home Page!',
//                       style: TextStyle(
//                         fontSize: 32,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//
//               // Description text below the image
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   children: [
//                     Text(
//                       'Manage your account and interactions here.',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               // Grid of Icons for navigation actions
//               Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: GridView.count(
//                   crossAxisCount: 3, // 3-column grid for icons
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   children: [
//                     _buildIconButton(
//                       icon: Icons.account_circle,
//                       label: 'View User',
//                       onTap: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => ViewUsersPage()));
//                       },
//                     ),
//                     _buildIconButton(
//                       icon: Icons.post_add,
//                       label: 'View My Post',
//                       onTap: () {
//
//                         // Handle this action
//                       },
//                     ),
//                     //  _buildIconButton(
//                     //   icon: Icons.group_add,
//                     //   label: 'Accept Friend Request',
//                     //   onTap: () {
//                     //     Navigator.push(context, MaterialPageRoute(builder: (context) => ViewFriendRequestsPage()));
//                     //   },
//                     // ),
//                      _buildIconButton(
//                       icon: Icons.group_add,
//                       label: 'Accept Friend Request',
//                       onTap: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => ViewRequest2()));
//                       },
//                     ),
//                     _buildIconButton(
//                       icon: Icons.group,
//                       label: 'View Friends',
//                       onTap: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => FriendRequestsPage()));
//                       },
//                     ),
//                     _buildIconButton(
//                       icon: Icons.add_box,
//                       label: 'Post',
//                       onTap: () {
//                         // Handle post action
//                       },
//                     ),
//                     _buildIconButton(
//                       icon: Icons.post_add_outlined,
//                       label: 'Other Post',
//                       onTap: () {
//                         // Handle other post action
//                       },
//                     ),
//                     _buildIconButton(
//                       icon: Icons.person,
//                       label: 'Profile',
//                       onTap: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(title: '',)));
//                       },
//                     ),
//                     _buildIconButton(
//                       icon: Icons.report_problem,
//                       label: 'Complaint',
//                       onTap: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => view_complaint(title: '',)));
//                       },
//                     ),
//                     _buildIconButton(
//                       icon: Icons.feedback,
//                       label: 'Feedback',
//                       onTap: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => UserFeedback(title: '',)));
//                       },
//                     ),
//                     _buildIconButton(
//                       icon: Icons.logout,
//                       label: 'Logout',
//                       onTap: () async {
//                         bool shouldLogout = await _showLogoutConfirmationDialog(context);
//                         if (shouldLogout) {
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(builder: (context) => LoginPage2()),
//                           );
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Function to create navigation icon buttons
//   Widget _buildIconButton({
//     required IconData icon,
//     required String label,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             icon,
//             size: 50.0,
//             color: Colors.blue[800],
//           ),
//           SizedBox(height: 10.0),
//           Text(
//             label,
//             style: TextStyle(
//               fontFamily: 'GoogleSansBold',
//               fontSize: 16,
//               color: Colors.blue[800],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Show logout confirmation dialog
//   Future<bool> _showLogoutConfirmationDialog(BuildContext context) async {
//     return await showDialog<bool>(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Confirm Logout'),
//           content: Text('Are you sure you want to log out?'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(true); // User confirmed logout
//               },
//               child: Text('Yes', style: TextStyle(color: Colors.red)),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(false); // User canceled logout
//               },
//               child: Text('No', style: TextStyle(color: Colors.green)),
//             ),
//           ],
//         );
//       },
//     ) ?? false;
//   }
//
//   // Show exit confirmation dialog for the back button
//   Future<bool> _showExitConfirmationDialog(BuildContext context) async {
//     return await showDialog<bool>(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Confirm Exit'),
//           content: Text('Do you want to exit the app?'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(true); // Exit the app
//               },
//               child: Text('Yes', style: TextStyle(color: Colors.red)),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(false); // Stay in the app
//               },
//               child: Text('No', style: TextStyle(color: Colors.green)),
//             ),
//           ],
//         );
//       },
//     ) ?? false;
//   }
// }
