import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';

import 'package:flutter/material.dart';
import 'package:startpfe/login_signup/LoginOwner.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:developer' as developer;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startpfe/screens/sms/sms.dart';


class SignUpOwner extends StatefulWidget {
  SignUpOwner({Key? key}) : super(key: key);

  @override
  _SignUpOwnerState createState() => _SignUpOwnerState();
}

class _SignUpOwnerState extends State<SignUpOwner> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _codePostalController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool _isNotValid = false;
  String _selectedImage = '';

  late SharedPreferences sharedPreferences;

  @override
  

  void registerPetOwner(BuildContext context) async {
  if (_emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _nameController.text.isNotEmpty &&
      _phoneController.text.isNotEmpty &&
      _codePostalController.text.isNotEmpty &&
      _passwordController.text == _confirmPasswordController.text) {
    if (_selectedImage.isNotEmpty) {
      try {
        File imageFile = File(_selectedImage);
        var stream = http.ByteStream(imageFile.openRead());
        var length = await imageFile.length();/*

        var request = http.MultipartRequest(
            /*'POST', Uri.parse('http://192.168.1.21:5000/register'));*/
            'POST', Uri.parse('http://10.0.2.2:5000/register'));

        var multipartFile = http.MultipartFile('image', stream, length,
            filename: basename(imageFile.path));
        
        request.fields['email'] = _emailController.text;
        request.fields['password'] = _passwordController.text;
        request.fields['name'] = _nameController.text;
        request.fields['phone'] = _phoneController.text;
        request.fields['codepostal'] = _codePostalController.text;

        request.files.add(multipartFile);

        var response = await request.send();
        if (response.statusCode == 200) {*/
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SmsStart()),
          );
        /*} else {
          setState(() {
            _isNotValid = true;
          });
        }*/
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('name', _nameController.text);
        prefs.setString('phone', _phoneController.text);
        prefs.setString('email', _emailController.text);
        prefs.setString('codepostal', _codePostalController.text);
        prefs.setString('password', _passwordController.text);
        prefs.setString('image', _selectedImage);
      } catch (e) {
        print('Error uploading image: $e');
        setState(() {
          _isNotValid = true;
        });
      }
       
  
    } 
  } else {
    setState(() {
      _isNotValid = true;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xffAD0E48),
                  Color(0xff165466),
                ]),
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 60.0, left: 22),
                child: Text(
                  'Create Your\nAccount',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.check, color: Colors.grey,),
                          label: const Text(
                            'Full Name',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffAD0E48),
                            ),
                          ),
                          errorText: _isNotValid && _nameController.text.isEmpty ? 'Please enter your name' : null,
                        ),
                      ),
                     TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.check, color: Colors.grey,),
                          label: const Text(
                            'Phone',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffAD0E48),
                            ),
                          ),
                          errorText: _isNotValid && _phoneController.text.isEmpty ? 'Please enter your phone number' : null,
                        ),
                      ),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.check, color: Colors.grey,),
                          label: const Text(
                            'Email',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffAD0E48),
                            ),
                          ),
                          errorText: _isNotValid && _emailController.text.isEmpty ? 'Please enter your email' : null,
                        ),
                      ),
                     TextField(
                          controller: _codePostalController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.check, color: Colors.grey,),
                            label: const Text(
                              'Code Postal',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xffAD0E48),
                              ),
                            ),
                            errorText: _isNotValid && _codePostalController.text.isEmpty ? 'Please enter your postal code' : null,
                          ),
                        ),
                      TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.visibility_off, color: Colors.grey,),
                            label: const Text(
                              'Password',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xffAD0E48),
                              ),
                            ),
                            errorText: _isNotValid && _passwordController.text.isEmpty ? 'Please enter your password' : null,
                          ),
                        ),
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.visibility_off, color: Colors.grey,),
                            label: const Text(
                              'Confirm Password',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xffAD0E48),
                              ),
                            ),
                            errorText: _isNotValid && _passwordController.text.isNotEmpty && _passwordController.text != _confirmPasswordController.text ? 'Password do not match' : null,
                          ),
                          onChanged: (value) {
                            setState(() {
                              _confirmPasswordController.text = value;
                            });
                          },
                        ),

                        picPicker(
                        _selectedImage.isNotEmpty, // Check if an image is selected
                        _selectedImage,
                        (file) {
                          if (file != null) {
                            setState(() {
                              _selectedImage = file.path; // Store the selected image file path
                              print('Selected image: $_selectedImage');
                              developer.log('Selected image: $_selectedImage', name: 'my.app.category');
                            });
                          }
                        },
                      ),
                        
                      const SizedBox(height: 10,),
                      const SizedBox(height: 70,),
                      GestureDetector(
                        onTap: () {
                          registerPetOwner(context);
                        },
                        child: Container(
                          height: 55,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xffAD0E48),
                                Color(0xff165466),
                              ]
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'SIGN IN',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 100,),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginOwner()),
                          );
                        },
                        child: const Align(
                          alignment: Alignment.bottomRight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Already have an account?",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                "Login",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Color(0xff165466),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget picPicker(
  bool isImageSelected,
  String fileName,
  Function onFilePicked,
) {
  Future<XFile?> _imageFile;
  ImagePicker _picker = ImagePicker();

  return Column(
    children: [
      fileName.isNotEmpty
          ? isImageSelected
              ? Image.file(
                  File(fileName),
                  width: 300,
                  height: 300,
                )
              : SizedBox(
                  child: Image.network(
                    fileName,
                    width: 200,
                    height: 200,
                    fit: BoxFit.scaleDown,
                  ),
                )
          : SizedBox(
              child: Image.network(
                "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png",
                width: 200,
                height: 200,
                fit: BoxFit.scaleDown,
              ),
            ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 35.0,
            width: 35.0,
            child: IconButton(
              padding: const EdgeInsets.all(0),
              icon: const Icon(Icons.image, size: 35.0),
              onPressed: () {
                _pickImage(ImageSource.gallery, onFilePicked);
              },
            ),
          ),
          SizedBox(
            height: 35.0,
            width: 35.0,
            child: IconButton(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              icon: const Icon(Icons.camera, size: 35.0),
              onPressed: () {
                _pickImage(ImageSource.camera, onFilePicked);
              },
            ),
          ),
        ],
      ),
    ],
  );
}

void _pickImage(ImageSource source, Function onFilePicked) async {
  ImagePicker _picker = ImagePicker();
  try {
    XFile? file = await _picker.pickImage(source: source);
    if (file != null) {
      onFilePicked(file);
    }
  } catch (e) {
    print('Error picking image: $e');
  }
}
