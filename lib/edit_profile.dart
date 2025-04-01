// import 'dart:io';
//
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:image_picker/image_picker.dart ';
//
//
// void main() {
//   runApp(const EditPickupHome());
// }
//
// class EditPickupHome extends StatelessWidget {
//   const EditPickupHome({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//
//       title: 'MySignup',
//       theme: ThemeData(
//
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const edit_profile(title: 'Worker '),
//     );
//   }
// }
//
// class edit_profile extends StatefulWidget {
//   const edit_profile({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<edit_profile> createState() => _ProfileState();
// }
//
// class _edit_profileState extends State<edit_profile> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     senddata();
//   }
//
//
//
//
//   TextEditingController nameController= new TextEditingController();
//   TextEditingController emailController= new TextEditingController();
//   TextEditingController phoneController= new TextEditingController();
//   TextEditingController placeController= new TextEditingController();
//   TextEditingController pinController= new TextEditingController();
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return WillPopScope(
//       onWillPop: () async{ return true; },
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.orange,
//           title: Text(widget.title),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               if (_selectedImage != null) ...{
//                 InkWell(
//                   child:
//                   Image.file(_selectedImage!, height: 400,),
//                   radius: 399,
//                   onTap: _checkPermissionAndChooseImage,
//                   borderRadius: BorderRadius.all(Radius.circular(200)),
//                 ),
//               } else ...{
//                 // Image(image: NetworkImage(),height: 100, width: 70,fit: BoxFit.cover,),
//                 InkWell(
//                   onTap: _checkPermissionAndChooseImage,
//                   child:Column(
//                     children: [
//                       Image(image: NetworkImage(photo_),height: 200,width: 200,),
//                       Text('Select Image',style: TextStyle(color: Colors.cyan))
//                     ],
//                   ),
//                 ),
//               },
//
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: TextField(
//                   controller: nameController,
//                   decoration: InputDecoration(border: OutlineInputBorder(),label: Text("User Name")),
//                 ),
//               ),
//
//              Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: TextField(
//                   keyboardType: TextInputType.emailAddress,
//
//                   controller: emailController,
//                   decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Email")),
//                 ),
//               ),
//
//
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: TextField(
//                   keyboardType: TextInputType.number,
//
//                   controller: phoneController,
//                   decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Phone")),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: TextField(
//                   keyboardType: TextInputType.name,
//
//                   controller: placeController,
//                   decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Place")),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: TextField(
//                   keyboardType: TextInputType.number,
//
//                   controller: pinController,
//                   decoration: InputDecoration(border: OutlineInputBorder(),label: Text("pin")),
//                 ),
//               ),
//
//
//
//
//
//
//
//
//
//
//               ElevatedButton(
//                 onPressed: () {
//
//                   _send_data() ;
//
//                 },
//                 child: Text("Update"),
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
//
//
//
//
//
//
//
//
//
//   void _send_data() async{
//
//
//
//
//     String name=nameController.text;
//     String phone=phoneController.text;
//     String email=emailController.text;
//
//     String place=placeController.text;
//     String pin=pinController.text;
//
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     String lid = sh.getString('lid').toString();
//     // url+'and_signup'
//     final urls = Uri.parse(url+'/edit_profile');
//     try {
//
//
//
//
//
//       final response = await http.post(urls, body: {
//         // "image1":photo,
//         'lid':lid,
//         'name':name,
//         'place':place,
//         'phone':phone,
//         'email':email,
//         'pin':pin,
//         'image':photo,
//
//
//
//
//       });
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status=='ok') {
//
//           Fluttertoast.showToast(msg: ' Successfull');
//           Navigator.push(context, MaterialPageRoute(
//             builder: (context) => user_profile(title: '',),));
//         }else {
//           Fluttertoast.showToast(msg: 'Not Found');
//         }
//       }
//       else {
//         Fluttertoast.showToast(msg: 'Network Error');
//       }
//     }
//     catch (e){
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
//
//
//
//
//
//
//
//
//
//
//
//
//
//   // First photo starts here
//   File? uploadimage;
//   File? _selectedImage;
//   String? _encodedImage;
//   Future<void> _chooseAndUploadImage() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage = File(pickedImage.path);
//         _encodedImage = base64Encode(_selectedImage!.readAsBytesSync());
//         photo = _encodedImage.toString();
//       });
//     }
//   }
//
//   Future<void> _checkPermissionAndChooseImage() async {
//     final PermissionStatus status = await Permission.mediaLibrary.request();
//     if (status.isGranted) {
//       _chooseAndUploadImage();
//     } else {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//           title: const Text('Permission Denied'),
//           content: const Text(
//             'Please go to app settings and grant permission to choose an image.',
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('OK'),
//             ),
//           ],
//         ),
//       );
//     }
//   }
//
//   String photo = '';
//   // First photo ends here
//
//
//   // Second photo starts here
//
//
//   File? uploadimage2;
//   File? _selectedImage2;
//   String? _encodedImage2;
//   Future<void> _chooseAndUploadImage2() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage2 = File(pickedImage.path);
//         _encodedImage2 = base64Encode(_selectedImage2!.readAsBytesSync());
//         // proof = _encodedImage2.toString();
//       });
//     }
//   }
//
//   Future<void> _checkPermissionAndChooseImage2() async {
//     final PermissionStatus status = await Permission.mediaLibrary.request();
//     if (status.isGranted) {
//       _chooseAndUploadImage2();
//     } else {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//           title: const Text('Permission Denied'),
//           content: const Text(
//             'Please go to app settings and grant permission to choose an image.',
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('OK'),
//             ),
//           ],
//         ),
//       );
//     }
//   }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//   //worker profile
//   String  photo_='';
//   void senddata()async{
//
//
//     SharedPreferences sh=await SharedPreferences.getInstance();
//     String url=sh.getString('url').toString();
//     String lid=sh.getString('lid').toString();
//     final urls=Uri.parse(url+"/user_view_profile");
//     try{
//       final response=await http.post(urls,body:{
//         'lid':lid,
//       });
//
//
//
//
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status=='ok') {
//           Fluttertoast.showToast(msg: 'Success');
//
//
//
//
//
//
//
//     setState(() {
//             emailController.text=jsonDecode(response.body)['email'];
//             nameController.text=jsonDecode(response.body)['name'];
//             phoneController.text=jsonDecode(response.body)['phone'];
//             placeController.text=jsonDecode(response.body)['place'];
//             pinController.text=jsonDecode(response.body)['pin'];
//             emailController.text=jsonDecode(response.body)['email'];
//             photo_=sh.getString("imgurl").toString()+jsonDecode(response.body)['image'];
//
//
//           });
//
//         }else {
//           Fluttertoast.showToast(msg: 'Not Found');
//         }
//       }
//       else {
//         Fluttertoast.showToast(msg: 'Network Error');
//       }
//     }
//     catch (e){
//       Fluttertoast.showToast(msg: e.toString());
//     }
//
//   }
//
//
// }
//

import 'dart:io';
import 'package:fakenews/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'newui.dart';


class EditStudProfile extends StatefulWidget {
  const EditStudProfile({super.key, required this.title});
  final String title;

  @override
  State<EditStudProfile> createState() => _EditStudProfileState();
}

class _EditStudProfileState extends State<EditStudProfile> {
  final _formKey = GlobalKey<FormState>();

  _EditStudProfileState() {
    _getData();
  }

  // Text controllers for the editable fields
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController postController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController ImageController = TextEditingController();

  // Variable to hold the old image URL
  String? _oldImageUrl;

  // Variable to hold selected image
  File? _selectedImage;

  // Method to get existing data
  void _getData() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse(url + 'view_profile');
    try {
      final response = await http.post(urls, body: {'lid': lid});
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          fnameController.text = jsonDecode(response.body)['fname'];
          lnameController.text = jsonDecode(response.body)['lname'];
          genderController.text = jsonDecode(response.body)['gender'];
          dobController.text = jsonDecode(response.body)['dob'];
          phoneController.text = jsonDecode(response.body)['phone'];
          emailController.text = jsonDecode(response.body)['email'];
          placeController.text = jsonDecode(response.body)['place'];
          postController.text = jsonDecode(response.body)['post'];
          pinController.text = jsonDecode(response.body)['pin'];
          ImageController.text = jsonDecode(response.body)['Image'];

          // Get the old image URL
          _oldImageUrl = jsonDecode(response.body)['Image']; // Assuming the key is 'photo'
        } else {
          Fluttertoast.showToast(msg: 'Data Not Found');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  // UI and form fields
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildTextField("firstName", fnameController, (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                }),
                _buildTextField("lastName", lnameController, (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                }),
                _buildTextField("gender", genderController, (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your place';
                  }
                  return null;
                }),
                _buildTextField("dob", dobController, (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your post';
                  }
                  return null;
                }),



                _buildTextField("phonenumber", phoneController, (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  if (!RegExp(r'^[6789]\d{9}$').hasMatch(value)) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                }),
                _buildTextField("Email", emailController, (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                }),
                _buildTextField("place", placeController, (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your post';
                  }
                  return null;
                }),
                _buildTextField("post", postController, (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your post';
                  }
                  return null;
                }),
                _buildTextField("pin", pinController, (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your pin';
                  }
                  return null;
                }),

                _buildImagePicker(),
                ElevatedButton(
                  onPressed: _sendData,
                  child: const Text("Update Profile"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper widget for text fields with validation
  Padding _buildTextField(
      String label, TextEditingController controller, String? Function(String?) validator) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
        ),
        validator: validator,
      ),
    );
  }

  // Image picker widget
  Widget _buildImagePicker() {
    return InkWell(
      onTap: _checkPermissionAndChooseImage,
      child: Column(
        children: [
          _selectedImage != null
              ? Image.file(_selectedImage!, height: 200, width: 200)
              : _oldImageUrl != null && _oldImageUrl!.isNotEmpty
              ? Image.network(
            _oldImageUrl!,
            height: 200,
            width: 200,
          )
              : Image.network(
            'https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png',
            height: 200,
            width: 200,
          ),
          const Text('Select Image', style: TextStyle(color: Colors.cyan)),
        ],
      ),
    );
  }

  // Method to choose and upload image
  Future<void> _chooseAndUploadImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  Future<void> _checkPermissionAndChooseImage() async {
    final PermissionStatus status = await Permission.mediaLibrary.request();
    if (status.isGranted) {
      _chooseAndUploadImage();
    } else {
      _showPermissionDeniedDialog();
    }
  }

  // Method to show permission denied dialog
  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Permission Denied'),
        content: const Text(
            'Please go to app settings and grant permission to choose an image.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Method to send data to backend
  void _sendData() async {
    if (_formKey.currentState!.validate()) {
      String fname = fnameController.text;
      String lname = lnameController.text;
      String gender = genderController.text;
      String dob = dobController.text;
      String phone = phoneController.text;
      String email = emailController.text;
      String place = placeController.text;
      String post = postController.text;
      String pin = pinController.text;
      String Image = ImageController.text;

      SharedPreferences sh = await SharedPreferences.getInstance();
      String url = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();

      final urls = Uri.parse(url + 'edit_profile');

      try {
        // Create a multipart request
        var request = http.MultipartRequest('POST', urls);
        request.fields['lid'] = lid;
        request.fields['fname'] = fname;
        request.fields['lname'] = lname;
        request.fields['gender'] = gender;
        request.fields['dob'] = dob;
        request.fields['phone'] = phone;
        request.fields['email'] = email;
        request.fields['place'] = place;
        request.fields['post'] = post;
        request.fields['pin'] = pin;
        request.fields['Image'] = Image;

        // Add the image file if selected
        if (_selectedImage != null) {
          request.files.add(await http.MultipartFile.fromPath(
            'Image', _selectedImage!.path,
          ));
        }

        // Send the request
        var response = await request.send();
        if (response.statusCode == 200) {
          // Read the response data
          final responseString = await response.stream.bytesToString();
          String status = jsonDecode(responseString)['status'];
          if (status == 'ok') {
            Fluttertoast.showToast(msg: 'Profile Updated Successfully');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeNewPage(title: '',)));
          } else {
            Fluttertoast.showToast(msg: 'Update Failed');
          }
        } else {
          Fluttertoast.showToast(msg: 'Network Error');
        }
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }
}










