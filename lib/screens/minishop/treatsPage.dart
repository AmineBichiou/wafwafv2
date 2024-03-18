import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:startpfe/dashboard.dart';

class Treat {
  final String id;
  final String name;
  final String description;
  final double price;
  final double salePrice;
  final String sku;
  final String status;
  //final String image;

  Treat({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.salePrice,
    required this.sku,
    required this.status,
    //required this.image,
  });
}

class TreatsPage extends StatefulWidget {
  @override
  _TreatsPageState createState() => _TreatsPageState();
}

class _TreatsPageState extends State<TreatsPage> {
  late Future<List<Treat>> _futureTreats;

  @override
  void initState() {
    super.initState();
    _futureTreats = fetchTreats();
  }
//static const String ipAddress = '192.168.139.24';
  Future<List<Treat>> fetchTreats() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:5000/getTreats'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<Treat> treats = data.map((treat) {
        return Treat(
          id: treat['_id'],
          name: treat['treatName'],
          description: treat['treatDescription'],
          price: treat['treatPrice'].toDouble(),
          salePrice: treat['treatSalePrice'].toDouble(),
          sku: treat['treatSKU'],
          status: treat['stockStatus'],
          //image: treat['treatImage'],
        );
      }).toList();
      return treats;
    } else {
      throw Exception('Failed to load treats');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shop',
          style: TextStyle(
            
            color: Color(0xFFED5986),
            fontFamily: 'YourCustomFont',
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back), 
            onPressed: (){
             Navigator.of(context).pop();

              },
            color: Colors.black,
  ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
            color: Colors.black,
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {},
            color: Colors.black,
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
            color: Colors.black,
          ),
        ],
      ),
      body: FutureBuilder<List<Treat>>(
  future: _futureTreats,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    } else {
      return GridView.count(
        crossAxisCount: 2,
        children: snapshot.data!.map((treat) {
          return _buildProductCard(treat.name, treat.description);
        }).toList(),
      );
    }
  },
),

    );
  }
}


 Widget _buildProductCard(String name, String description, /*String imageUrl*/) {
    return Card(
      margin: EdgeInsets.all(8.0),
      color: Color(0xFFE6BECD), // Set the card color here
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /*Expanded(
            child: Image.asset(
            imageUrl,
              fit: BoxFit.cover,
            ),
          ),*/
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        description,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {
                    // Handle favorite icon press
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

