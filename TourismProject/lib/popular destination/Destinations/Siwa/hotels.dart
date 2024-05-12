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
      "Albabenshal-guest House",
      [
        'images/siwahotels/alb1.jpg',
        'images/siwahotels/alb2.jpg',
        'images/siwahotels/alb3.jpg',
        'images/siwahotels/alb4.jpg',
      ],
      "Albabenshal Guest House: Your cozy retreat in siwa",
      0),
  Hotel(
      "Forest camp Siwa",
      [
        'images/siwahotels/for1.jpg',
        'images/siwahotels/for2.jpg',
        'images/siwahotels/for3.jpg',
        'images/siwahotels/for4.jpg',
      ],
      "Forest Camp Siwa: Your serene oasis amidst nature's embrace.",
      0),
  Hotel(
      'Shali Ladge',
      [
        'images/siwahotels/shali1.jpg',
        'images/siwahotels/shali2.jpg',
        'images/siwahotels/shali3.jpg',
        'images/siwahotels/shali4.jpg',
      ],
      "Shali Lodge: Your serene oasis in Siwa",
      0),
  Hotel(
      'Siwa Paradise',
      [
        'images/siwahotels/para1.jpg',
        'images/siwahotels/para2.jpg',
        'images/siwahotels/para3.jpg',
        'images/siwahotels/para4.jpg',
      ],
      "Siwa Paradise: Where desert serenity meets comfort, promising an unforgettable oasis retreat.",
      0),
  Hotel(
      'Siwa Camp Osman Oasis',
      [
        'images/siwahotels/camp1.jpg',
        'images/siwahotels/camp2.jpg',
        'images/siwahotels/camp3.jpg',
        'images/siwahotels/camp4.jpg',
      ],
      "Siwa Camp Osman Oasis: Your tranquil retreat amidst the beauty of Siwa's natural splendor.",
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
              MaterialPageRoute(builder: (context) => FourthRoute()),
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
