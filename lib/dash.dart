import 'package:flutter/material.dart';

class Dash extends StatelessWidget {
  const Dash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(
            color: Color(0xFFED5986), // Text color
            fontFamily:
                'YourCustomFont', // Replace 'YourCustomFont' with your desired font
          ),
        ),
        elevation: 0, // Set elevation to zero
        backgroundColor:
            Colors.transparent, // Set background color to transparent
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notification icon press
            },
            color: Colors.black, // Set icon color to black
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Handle person icon press
            },
            color: Colors.black, // Set icon color to black
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 40), // Add some space
            Text(
              'Petsetters in your area',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFFED5986),
              ),
            ),
            SizedBox(height: 40), // Add some space
            SizedBox(
              height: 300, // Adjust the height here
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFED5986)), // Add border
                  borderRadius: BorderRadius.circular(10), // Add border radius
                ),
                child: Center(
                  child: Text(
                    'Map',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 40),

            Text(
              'Find a new pet setter',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFFED5986),
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              height: 150, // Adjust the height here
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFED5986)), // Add border
                  borderRadius: BorderRadius.circular(10), // Add border radius
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/dog.png', // Add the path to your image
                        width: 100, // Adjust the width of the image
                        height: 100, // Adjust the height of the image
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Find a new\npet setter',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Our setters are excited for your pet',
                          style: TextStyle(
                            fontSize: 8,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Add your button action here
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFFED5986), // Button color
                          ),
                          child: Text('Click Here'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
