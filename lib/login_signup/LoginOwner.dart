import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startpfe/dashboard.dart';
import 'package:startpfe/login_signup/SignUpOwner.dart';

class LoginOwner extends StatefulWidget {
  LoginOwner({Key? key}) : super(key: key);

  @override
  _LoginOwnerState createState() => _LoginOwnerState();
}

class _LoginOwnerState extends State<LoginOwner> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isNotValid = false;
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  void initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  void loginOwner() async{
    if(_emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty){
      var petOwner = {
        'email': _emailController.text,
        'password': _passwordController.text
      };
      var response = await http.post(Uri.parse('http://10.0.2.2:5000/login'),
      body: jsonEncode(petOwner),
      headers: {'Content-Type': 'application/json'});
      var message = jsonDecode(response.body);
      if(message['status']){
        var theToken = message['token'];
        sharedPreferences.setString('token', theToken);
        Navigator.push(context,MaterialPageRoute(builder: (context) => Dashboard(token: theToken)),);
      }
      else{
        setState(() {
          _isNotValid = true;

        });
      }
      

  }
  else {
    setState(() {
      _isNotValid = true;
    });

  }
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: Stack(
      children: [
        Container(
          height: double.infinity,
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
              'Waf Waf House\nWelcomes You',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 200.0),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              color: Colors.white,
            ),
            height: double.infinity,
            width: double.infinity,
            
            child:  Padding(
              padding: const EdgeInsets.only(left: 18.0,right: 18),
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.check, color: Colors.grey,),
                        label: Text(
                          'Email',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:Color(0xffAD0E48),
                          ),
                        ),
                        errorText: _isNotValid && _emailController.text.isEmpty ? 'Please enter your email' : null,
                      ),
                    ),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.visibility_off, color: Colors.grey,),
                        label: Text(
                          'Password',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:Color(0xffAD0E48),
                          ),
                        ),
                        errorText: _isNotValid && _passwordController.text.isEmpty ? 'Please enter your password' : null,
                      ),
                    ),
                  const SizedBox(height: 20,),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text('Forgot Password?',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Color(0xff165466),
                    ),),
                  ),
                  const SizedBox(height: 70,),
                 GestureDetector(
                        onTap: () {
                          loginOwner();
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
                              'LOGIN',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),

                  const SizedBox(height: 150,),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUpOwner()),
                          );
                        },
                        child: const Align(
                          alignment: Alignment.bottomRight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("Don't have an account?", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey
                              ),),
                              Text("Sign up", style: TextStyle(///done login page
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Color(0xff165466),
                              ),),
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
    ));
  }
}