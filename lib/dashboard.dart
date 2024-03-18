import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as developer;
import 'package:geolocator/geolocator.dart';

import 'dart:async';

import 'package:startpfe/login_signup/LoginOwner.dart';
import 'package:startpfe/screens/petowner/profile.dart';
import 'package:startpfe/screens/minishop/treatsPage.dart';

class Dashboard extends StatefulWidget {
  final token;
  Dashboard({@required this.token, Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late String email;
  late String id = '';
  LatLng? pickLocation;
  String? _address;
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();

  GoogleMapController? newGoogleMapController;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

  Position? userCurrentPosition;
  var geoLocation = Geolocator();
  LocationPermission? _locationPermission;
  double bottomPadding0fMap = 0;
  List<LatLng> pLineCoOrdinatesList = [];
  Set<Polyline> polylineSet = {};
  Set<Marker> markerSet = {};
  Set<Circle> circleSet = {};
  String userEmail = "";
  bool openNavigationDrawer = true;
  bool activeNearbyDriverKeysLoaded = false;
  BitmapDescriptor? activeNearbyIcon;
  bool requestPositionInfo = true;

  @override
  

  locateUserPosition() async {
    Position cPostion = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    userCurrentPosition = cPostion;
    LatLng latLngPosition =
        LatLng(userCurrentPosition!.latitude, userCurrentPosition!.longitude);
    CameraPosition cameraPosition =
        CameraPosition(target: latLngPosition, zoom: 15);
    newGoogleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    // Add marker for user's current location
    setState(() {
      markerSet.add(
        Marker(
          markerId: MarkerId('userLocation'),
          position: latLngPosition,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(title: 'Your Location'),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    locateUserPosition();
    Map<String, dynamic> decodedToken = JwtDecoder.decode(widget.token);
    email = decodedToken['email'];
    getId();
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginOwner()),
    );
  }

  Future<void> getId() async {
    try {
      var response = await http.get(
        Uri.parse('http://10.0.2.2:5000/getIdByEmail/$email'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var message = jsonDecode(response.body);
        developer.log('ID obtained: $message');
        setState(() {
          id = message;
        });
        print('ID obtained: $id');
      } else {
        throw Exception('Failed to get ID');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 100,
        width: 90,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            //border: Border.all(color: Colors.black, width: 2),
          ),
          child: FloatingActionButton(
            onPressed: () {
              // Add your onPressed logic here
            },
            child: Image.asset('assets/waflogo.png'),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 2,
        shape:CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        color: Color(0xFFED5986),
        height: 60%MediaQuery.of(context).size.height,
        child: Row(
          
          children: [
            
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.home),
              iconSize: 40,
              color: Colors.white,
            ),
            SizedBox(width: 20),
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.history),
              iconSize: 40,
              color: Colors.white,
            ),
            SizedBox(width: 110),
            IconButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TreatsPage()) ,
                );
              },
              icon: Icon(Icons.shopping_cart_outlined),
              iconSize: 40,
              color: Colors.white,
            ),
            SizedBox(width: 30),
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.message_sharp),
              iconSize: 40,
              color: Colors.white,
            ),
          ],
        ),

      ),
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(
            color: Color(0xFFED5986),
            fontFamily:
                'YourCustomFont', 
          ),
        ),
        elevation: 0,
        backgroundColor:
            Colors.transparent, 
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
              
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage(id: id)),
              );
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
                child: GoogleMap(
                  mapType: MapType.normal,
                  myLocationButtonEnabled: true,
                  zoomGesturesEnabled: true,
                  polylines: polylineSet,
                  markers: markerSet,
                  initialCameraPosition: userCurrentPosition != null
                      ? CameraPosition(
                          target: LatLng(userCurrentPosition!.latitude,
                              userCurrentPosition!.longitude),
                          zoom: 15,
                        )
                      : _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controllerGoogleMap.complete(controller);
                    newGoogleMapController = controller;
                  },
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
                        'assets/doggy.png', // Add the path to your image
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => TreatsPage()),
                              );
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
             SizedBox(height: 40),
      Text(
        'Services',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFFED5986),
        ),
      ),
      SizedBox(height: 20),
      GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 3, // Three cards per row
            children: [
              // List of cards
               Card(
      child: InkWell(
        onTap: () {
          // Add onPressed logic here
        },
        child: Center(
          child: Text(
            'Garde chez le Pet Sitter',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Color(0xFFED5986)),
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 10,
      margin: EdgeInsets.all(8),
    ),
    Card(
      child: InkWell(
        onTap: () {
          // Add onPressed logic here
        },
        child: Center(
          child: Text(
            'Garde chez moi',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Color(0xFFED5986)),
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 10,
      margin: EdgeInsets.all(8),
    ),
    Card(
      child: InkWell(
        onTap: () {
          // Add onPressed logic here
        },
        child: Center(
          child: Text(
            'Promenade',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Color(0xFFED5986)),
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 10,
      margin: EdgeInsets.all(8),
    ),
    Card(
      child: InkWell(
        onTap: () {
          // Add onPressed logic here
        },
        child: Center(
          child: Text(
            'Visite a la maison',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Color(0xFFED5986)),
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 10,
      margin: EdgeInsets.all(8),
    ),
    Card(
      child: InkWell(
        onTap: () {
          // Add onPressed logic here
        },
        child: Center(
          child: Text(
            'Garderie du jour',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Color(0xFFED5986)),
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 10,
      margin: EdgeInsets.all(8),
    ),
    Card(
      child: InkWell(
        onTap: () {
          // Add onPressed logic here
        },
        child: Center(
          child: Text(
            'Transport',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Color(0xFFED5986)),
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 10,
      margin: EdgeInsets.all(8),
    ),
              
            ],
          ),

      
          ],
        ),
      ),
    );
  }
}
