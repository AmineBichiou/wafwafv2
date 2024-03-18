import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startpfe/login_signup/LoginOwner.dart';
import 'package:startpfe/screens/petowner/profileMenu.dart';

class ProfilePage extends StatefulWidget {
  final String? id;

  ProfilePage({required this.id});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? petOwnerData;
  String imageUrl = ''; 
  String baseUrl = "http://10.0.2.2:5000";

  @override
  void initState() {
    super.initState();
    fetchData();
  }


  String getImageFilename(String imageUrl) {
  Uri uri = Uri.parse(imageUrl);
  return uri.pathSegments.last;
}

  

  Future<void> fetchData() async {
    try {
      var response = await http.get(
        Uri.parse('$baseUrl/getPetOwnerById/${widget.id}'),
      );

      if (response.statusCode == 200) {
        setState(() {
          petOwnerData = json.decode(response.body);
          //petOwnerData!['image'] = imageUrl;
          print(petOwnerData!['image']);
        });
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
  String formater(String url) {
  return baseUrl + url;
}


NetworkImage getImage(String username) {
  String formattedUrl = formater("/uploads/$username");
  return NetworkImage(formattedUrl);
}
void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginOwner()),
    );
  }

  @override
Widget build(BuildContext context) {
  var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
  return Scaffold(
    appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
            icon: const Icon(LineAwesomeIcons.angle_left),
            onPressed: (){
             Navigator.of(context).pop();

              },
            color: Colors.black,
  ),
      title: Center(
        child: Text(
          'Profile',
          style: Theme.of(context).textTheme.headline4?.copyWith(
            fontWeight: FontWeight.bold,
            color: Color(0xFFED5986),
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon),
        ),
      ],
    ),
    body: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            /// -- IMAGE
            Stack(
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: petOwnerData != null && petOwnerData!['image'] != null
                      ? Image(
                          image: AssetImage(
                            'assets/Profiles/${getImageFilename(petOwnerData!['image'])}',
                          ),
                          fit: BoxFit.cover,
                        )
                      : Container(), // Placeholder or loading indicator can be added here
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.white),
                    child: const Icon(
                      LineAwesomeIcons.alternate_pencil,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Check if petOwnerData is not null before accessing its properties
            Text(
              petOwnerData != null ? '${petOwnerData!['name']}' : '',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              petOwnerData != null ? '${petOwnerData!['email']}' : '',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(height: 20),

            /// -- BUTTON
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFED5986), side: BorderSide.none, shape: const StadiumBorder()
                ),
                child: const Text('Edit Profile', style: TextStyle(color: Colors.black)),
              ),
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 10),

            /// -- MENU
            ProfileMenuWidget(title: "Billing Details", icon: LineAwesomeIcons.wallet, onPress: () {}),
            ProfileMenuWidget(title: "Check your Pet", icon: LineAwesomeIcons.user_check, onPress: () {}),
            const Divider(),
            const SizedBox(height: 10),
            ProfileMenuWidget(title: "Information", icon: LineAwesomeIcons.info, onPress: () {}),
            ProfileMenuWidget(
              title: "Logout",
              icon: LineAwesomeIcons.alternate_sign_out,
              textColor: Colors.red,
              endIcon: false,
              onPress: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("LOGOUT"),
                      content: Text("Are you sure, you want to Logout?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: Text("No"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            logout();
                            Navigator.of(context).pop(); // Close the dialog after logout
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            side: BorderSide.none,
                          ),
                          child: Text("Yes"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
}

}

