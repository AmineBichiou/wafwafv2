import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:startpfe/login_signup/LoginOwner.dart';

class VerificationSuccessScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(ScreenUtil().setWidth(24)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/ok.png',
                    width: ScreenUtil().setWidth(250),
                    height: ScreenUtil().setWidth(250),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(16)),
                  Text(
                    'Verified',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(24),
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(16)),
                  FutureBuilder(
                    future: _getDataFromSharedPreferences(),
                    builder: (BuildContext context, AsyncSnapshot<Map<String, String>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(); // or any loading indicator
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        // Display data retrieved from SharedPreferences
                        String name = snapshot.data!['name'] ?? '';
                        String phone = snapshot.data!['phone'] ?? '';
                        String email = snapshot.data!['email'] ?? '';
                        String codepostal = snapshot.data!['codepostal'] ?? '';
                        String password = snapshot.data!['password'] ?? '';
                        String image = snapshot.data!['image'] ?? '';

                        return Column(
                          children: [
                            Text(
                              'Name: $name',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(16),
                              ),
                            ),
                            Text(
                              'Phone: $phone',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(16),
                              ),
                            ),
                            Text(
                              'Email: $email',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(16),
                              ),
                            ),
                            Text(
                              'Code Postal: $codepostal',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(16),
                              ),
                            ),
                            Text(
                              'Password: $password',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(16),
                              ),
                            ),
                            // You can display more data as needed
                          ],
                        );
                      }
                    },
                  ),
                  SizedBox(height: ScreenUtil().setHeight(40)),
                  Container(
                    width: ScreenUtil()
                        .setWidth(0.6 * MediaQuery.of(context).size.width),
                    child: ElevatedButton(
                      onPressed: () {
                        registerPetOwner(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromRGBO(143, 130, 244, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: ScreenUtil().setHeight(16),
                        ),
                      ),
                      child: Text(
                        'Done',
                        style: TextStyle(fontSize: ScreenUtil().setSp(18)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Map<String, String>> _getDataFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('name') ?? '';
    String phone = prefs.getString('phone') ?? '';
    String email = prefs.getString('email') ?? '';
    String codepostal = prefs.getString('codepostal') ?? '';
    String password = prefs.getString('password') ?? '';
    String image = prefs.getString('image') ?? '';

    return {
      'name': name,
      'phone': phone,
      'email': email,
      'codepostal': codepostal,
      'password': password,
      'image': image,
    };
  }

  void registerPetOwner(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('name') ?? '';
    String phone = prefs.getString('phone') ?? '';
    String email = prefs.getString('email') ?? '';
    String codepostal = prefs.getString('codepostal') ?? '';
    String password = prefs.getString('password') ?? '';
    String image = prefs.getString('image') ?? '';
    
        try {
          File imageFile = File(image);
          var stream = http.ByteStream(imageFile.openRead());
          var length = await imageFile.length();

          var request = http.MultipartRequest(
              /*'POST', Uri.parse('http://192.168.1.21:5000/register'));*/
              'POST', Uri.parse('http://10.0.2.2:5000/register'));

          var multipartFile = http.MultipartFile('image', stream, length,
              filename: basename(imageFile.path));

          request.fields['email'] = email;
          request.fields['password'] = password;
          request.fields['name'] = name;
          request.fields['phone'] = phone;
          request.fields['codepostal'] = codepostal;

          request.files.add(multipartFile);

          var response = await request.send();
          if (response.statusCode == 200) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginOwner()),
            );
          } else {
            // Handle error
          }
        } catch (e) {
          // Handle error
        }
      }
    }
  