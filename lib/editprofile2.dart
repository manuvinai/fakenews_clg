// import 'dart:html';
//
// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'home.dart';
// import 'newui.dart';
//
//
// class EditStudProfile2 extends StatefulWidget {
//   const EditStudProfile2({super.key, required this.title});
//   final String title;
//
//   @override
//   State<EditStudProfile2> createState() => _EditStudProfile2State();
// }
//
// class _EditStudProfile2State extends State<EditStudProfile2> {
//   final _formKey = GlobalKey<FormState>();
//
//   TextEditingController fnameController = TextEditingController();
//   TextEditingController lnameController = TextEditingController();
//   TextEditingController genderController = TextEditingController();
//   TextEditingController dobController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController postController = TextEditingController();
//   TextEditingController pinController = TextEditingController();
//   TextEditingController placeController = TextEditingController();
//   TextEditingController imageController = TextEditingController();
//
//   String? _oldImageUrl;
//   File? _selectedImage;
//
//   @override
//   void initState() {
//     super.initState();
//     _getData();
//   }
//
//   void _getData() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     String lid = sh.getString('lid').toString();
//
//     final urls = Uri.parse(url + 'view_profile');
//     try {
//       final response = await http.post(urls, body: {'lid': lid});
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status == 'ok') {
//           fnameController.text = jsonDecode(response.body)['fname'];
//           lnameController.text = jsonDecode(response.body)['lname'];
//           genderController.text = jsonDecode(response.body)['gender'];
//           dobController.text = jsonDecode(response.body)['dob'];
//           phoneController.text = jsonDecode(response.body)['phone'];
//           emailController.text = jsonDecode(response.body)['email'];
//           placeController.text = jsonDecode(response.body)['place'];
//           postController.text = jsonDecode(response.body)['post'];
//           pinController.text = jsonDecode(response.body)['pin'];
//           imageController.text = jsonDecode(response.body)['Image'];
//
//           _oldImageUrl = jsonDecode(response.body)['Image'];
//         } else {
//           _showError("Data Not Found");
//         }
//       } else {
//         _showError("Network Error");
//       }
//     } catch (e) {
//       _showError(e.toString());
//     }
//   }
//
//   void _showError(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => true,
//       child: Scaffold(
//         backgroundColor: Colors.blue[50],
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           backgroundColor: Colors.blue,
//           elevation: 0.0,
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               IconButton(
//                 icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//               ),
//               Text(
//                 'Edit Profile',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(width: 40),
//             ],
//           ),
//         ),
//         body: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Edit Your Profile",
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blue[900],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 _buildImagePicker(),
//                 const SizedBox(height: 20),
//                 _buildTextField("First Name", fnameController, "Please enter your first name"),
//                 const SizedBox(height: 20),
//                 _buildTextField("Last Name", lnameController, "Please enter your last name"),
//                 const SizedBox(height: 20),
//                 _buildTextField("Gender", genderController, "Please enter your gender"),
//                 const SizedBox(height: 20),
//                 _buildTextField("Date of Birth", dobController, "Please enter your date of birth"),
//                 const SizedBox(height: 20),
//                 _buildTextField("Phone Number", phoneController, "Please enter your phone number", isPhone: true),
//                 const SizedBox(height: 20),
//                 _buildTextField("Email", emailController, "Please enter your email", isEmail: true),
//                 const SizedBox(height: 20),
//                 _buildTextField("Place", placeController, "Please enter your place"),
//                 const SizedBox(height: 20),
//                 _buildTextField("Post", postController, "Please enter your post"),
//                 const SizedBox(height: 20),
//                 _buildTextField("Pin", pinController, "Please enter your pin"),
//                 const SizedBox(height: 30),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     primary: Colors.blue,
//                     minimumSize: Size(double.infinity, 50),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   onPressed: _sendData,
//                   child: Text(
//                     "Update Profile",
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Padding _buildTextField(String label, TextEditingController controller, String validationMessage, {bool isPhone = false, bool isEmail = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           prefixIcon: Icon(Icons.edit),
//           filled: true,
//           fillColor: Colors.white,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide.none,
//           ),
//           contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//         ),
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return validationMessage;
//           }
//           if (isPhone && !RegExp(r'^[6789]\d{9}$').hasMatch(value)) {
//             return 'Please enter a valid phone number';
//           }
//           if (isEmail && !RegExp(r'^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$').hasMatch(value)) {
//             return 'Please enter a valid email';
//           }
//           return null;
//         },
//       ),
//     );
//   }
//
//   Widget _buildImagePicker() {
//     return GestureDetector(
//       onTap: _checkPermissionAndChooseImage,
//       child: Column(
//         children: [
//           _selectedImage != null
//               ? CircleAvatar(
//             radius: 80,
//             backgroundImage: FileImage(_selectedImage!),
//           )
//               : _oldImageUrl != null && _oldImageUrl!.isNotEmpty
//               ? CircleAvatar(
//             radius: 80,
//             backgroundImage: NetworkImage(_oldImageUrl!),
//           )
//               : const CircleAvatar(
//             radius: 80,
//             backgroundImage: NetworkImage(
//               'https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png',
//             ),
//           ),
//           const SizedBox(height: 10),
//           const Text('Tap to select image', style: TextStyle(color: Colors.cyan)),
//         ],
//       ),
//     );
//   }
//
//   Future<void> _chooseAndUploadImage() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage = File(pickedImage.path);
//       });
//     }
//   }
//
//   Future<void> _checkPermissionAndChooseImage() async {
//     final PermissionStatus status = await Permission.mediaLibrary.request();
//     if (status.isGranted) {
//       _chooseAndUploadImage();
//     } else {
//       _showPermissionDeniedDialog();
//     }
//   }
//
//   void _showPermissionDeniedDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         title: const Text('Permission Denied'),
//         content: const Text('Please go to app settings and grant permission to choose an image.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _sendData() async {
//     if (_formKey.currentState!.validate()) {
//       String fname = fnameController.text;
//       String lname = lnameController.text;
//       String gender = genderController.text;
//       String dob = dobController.text;
//       String phone = phoneController.text;
//       String email = emailController.text;
//       String place = placeController.text;
//       String post = postController.text;
//       String pin = pinController.text;
//       String image = imageController.text;
//
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String url = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//
//       final urls = Uri.parse(url + 'edit_profile');
//       try {
//         var request = http.MultipartRequest('POST', urls);
//         request.fields['lid'] = lid;
//         request.fields['fname'] = fname;
//         request.fields['lname'] = lname;
//         request.fields['gender'] = gender;
//         request.fields['dob'] = dob;
//         request.fields['phone'] = phone;
//         request.fields['email'] = email;
//         request.fields['place'] = place;
//         request.fields['post'] = post;
//         request.fields['pin'] = pin;
//         request.fields['Image'] = image;
//
//         if (_selectedImage != null) {
//           request.files.add(await http.MultipartFile.fromPath('Image', _selectedImage!.path));
//         }
//
//         var response = await request.send();
//         if (response.statusCode == 200) {
//           final responseString = await response.stream.bytesToString();
//           String status = jsonDecode(responseString)['status'];
//           if (status == 'ok') {
//             _showError('Profile Updated Successfully');
//             Navigator.pushReplacement(
//                 context, MaterialPageRoute(builder: (context) => HomeNewPage(title: '')));
//           } else {
//             _showError('Update Failed');
//           }
//         } else {
//           _showError('Network Error');
//         }
//       } catch (e) {
//         _showError(e.toString());
//       }
//     }
//   }
// }
