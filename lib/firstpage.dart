

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'secondpage.dart';



class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Image.asset(
            "assets/pawnpink.png",
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
            alignment: Alignment.topLeft,
            child: Image.asset(
              "assets/sun.png",
              width: 150,
              height: 400,
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment(0.1, 0),
            child:ElevatedButton(
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
                  MaterialPageRoute(builder: (context) => const SecondPage()),
                );
              },
              child: Text(
                "Get Started",
                textAlign: TextAlign.center,
                style: GoogleFonts.comicNeue(
                  textStyle: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment(0.5,-0.2),
            child: Text(
              "STRESS FREE GATEAWAY WITH WAF WAF",
              textAlign: TextAlign.center,
              style: GoogleFonts.comicNeue(
                textStyle: TextStyle(
                  color: Color(0xFF088653),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              "assets/cat.png",
              width: 550,
              height: 350,
            ),
          ),
        ),
      ],
    );
  }
}



