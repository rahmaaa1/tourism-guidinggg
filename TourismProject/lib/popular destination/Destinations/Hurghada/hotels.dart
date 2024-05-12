import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Hotel {
  final String name;
  final List<String> imagePaths;
  final String description;
  final int price;

  Hotel(this.name, this.imagePaths, this.description, this.price);
}

List<Hotel> hotels = [
  Hotel(
      "Baron Palace Sahl Hasheesh",
      [
        'images/hurghadahotels/hur1.jpg',
        'images/hurghadahotels/hur2.jpg',
        'images/hurghadahotels/hur3.jpg',
        'images/hurghadahotels/hur4.jpg',
      ],
      "Nestled amidst the sun-kissed shores of Hurghada, the Baron Palace Hotel exudes an enchanting charm, where every moment is a symphony of luxury, pampering guests with opulent indulgence against the backdrop of the Red Sea's azure embrace.",
      0),
  Hotel(
      "Giftun Beach Resort",
      [
        'images/hurghadahotels/gif1.jpg',
        'images/hurghadahotels/gif2.jpg',
        'images/hurghadahotels/gif3.jpg',
        'images/hurghadahotels/gif4.jpg',
      ],
      "Giftun Beach: Where sun, sand, and sea unite in a tranquil paradise, offering a perfect escape for those seeking serenity by the Red Sea.",
      0),
  Hotel(
      'Panorama Bungalows Resort El Gouna',
      [
        'images/hurghadahotels/pano1.jpg',
        'images/hurghadahotels/pano2.jpg',
        'images/hurghadahotels/pano3.jpg',
        'images/hurghadahotels/pano4.jpg',
      ],
      "Panorama Hotel: Where every stay offers unforgettable views and comfort in every corner.",
      0),
  Hotel(
      'Rixos Premium Magawish Suites & Villas',
      [
        'images/hurghadahotels/rixos1.jpg',
        'images/hurghadahotels/rixos2.jpg',
        'images/hurghadahotels/rixos3.jpg',
        'images/hurghadahotels/rixos4.jpg',
      ],
      "Rixos: Luxury and lifestyle harmonize, delivering an exceptional experience in opulence and service.",
      0),
  Hotel(
      'Serry Beach Resort',
      [
        'images/hurghadahotels/serry1.jpg',
        'images/hurghadahotels/serry2.jpg',
        'images/hurghadahotels/serry3.jpg',
        'images/hurghadahotels/serry4.jpg',
      ],
      "Serry Beach Hotel: Where serenity meets the sea for an unforgettable escape.",
      0)
  // Add more hotels here
];

class ScreenOne extends StatefulWidget {
  ScreenOne({Key? key});

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  List<int> activeIndices = List.filled(hotels.length, 0);
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getHotelPrices();
  }

  Future<void> getHotelPrices() async {
    for (int i = 0; i < hotels.length; i++) {
      DocumentSnapshot document = await FirebaseFirestore.instance
          .collection('Hotels')
          .doc(hotels[i].name)
          .get();
      if (document.exists) {
        int price = document.get('price');
        hotels[i] = Hotel(
          hotels[i].name,
          hotels[i].imagePaths,
          hotels[i].description,
          price,
        );
        if (price == 0) {
          setState(() {
            isLoading = true;
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
      } else {
        print('Document does not exist');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cairo',
          style: TextStyle(
            fontFamily: 'MadimiOne',
            color: Color.fromARGB(255, 121, 155, 228),
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Color.fromARGB(255, 121, 155, 228),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FifthRoute()),
            );
          },
        ),
      ),
      body: ListView(
        children: [
          Center(
            child: Text(
              'Hotels',
              style: TextStyle(
                fontFamily: 'MadimiOne',
                color: Color.fromARGB(255, 121, 155, 230),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          for (int i = 0; i < hotels.length; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items: hotels[i]
                      .imagePaths
                      .map((imagePath) => Container(
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(imagePath),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ))
                      .toList(),
                  options: CarouselOptions(
                    height: 180,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    autoPlay: false,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        activeIndices[i] = index;
                      });
                    },
                  ),
                ),
                SizedBox(height: 10),
                buildIndicator(activeIndices[i], hotels[i].imagePaths.length),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      SizedBox(width: 8),
                      Text(
                        hotels[i].name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'MadimiOne',
                          color: Color.fromARGB(255, 83, 137, 182),
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.location_on,
                        color: Color.fromARGB(255, 5, 59, 107),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Added to Favourite!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.favorite_outline,
                          color: Color.fromARGB(255, 13, 16, 74),
                        ),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Added to Trip!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.add_circle_outline,
                          color: Color.fromARGB(255, 13, 16, 74),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    hotels[i].description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 36, 108, 163),
                      fontFamily: 'MadimiOne',
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      if (isLoading)
                        CircularProgressIndicator(), // Show loading icon
                      if (!isLoading && hotels[i].price != 0)
                        Text(
                          hotels[i].price.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 5, 59, 107),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (!isLoading && hotels[i].price != 0)
                        SizedBox(width: 8),
                      if (!isLoading && hotels[i].price != 0)
                        Text(
                          "EGP",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 5, 59, 107),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
        ],
      ),
    );
  }

  Widget buildIndicator(int activeIndex, int length) {
    return Center(
      child: AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: length,
        effect: WormEffect(
          dotWidth: 18,
          dotHeight: 18,
          activeDotColor: Colors.blue,
          dotColor: Color.fromARGB(255, 16, 65, 106),
        ),
      ),
    );
  }
}
