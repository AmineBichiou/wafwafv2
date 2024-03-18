import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:startpfe/login_signup/LoginOwner.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Image.asset(
              "assets/pawnpink1.png",
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                "assets/wafpawn.png",
                width: 200,
                height: 150,
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment(0.9, 0.5),
              child: Image.asset(
                "assets/sp.png",
                width: 150,
                height: 400,
              ),
            ),
          ),
          Positioned.fill(
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Adjust as needed
    children: [
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color(0xFF088653),
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  LoginOwner()),
                );
        },
        child: Text(
          "Pet Owner",
          textAlign: TextAlign.center,
          style: GoogleFonts.comicNeue(
            textStyle: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color(0xFF088653),
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          // Add navigation logic for pet sitter button if needed
        },
        child: Text(
          "Pet Sitter",
          textAlign: TextAlign.center,
          style: GoogleFonts.comicNeue(
            textStyle: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ],
  ),
),

          Positioned.fill(      
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start, 
      children: [
        SizedBox(height: 250),
        Text(
          "Need a Pet Sitter or looking to Pet Sit?",
          textAlign: TextAlign.center,
          style: GoogleFonts.comicNeue(
            textStyle: TextStyle(
              color: Color(0xFF088653),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          "Get Started Here",
          textAlign: TextAlign.center,
          style: GoogleFonts.comicNeue(
            textStyle: TextStyle(
              color: Color(0xFF088653),
              fontSize: 25, // Adjust font size as needed
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                "assets/dog.png",
                width: 550,
                height: 350,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
