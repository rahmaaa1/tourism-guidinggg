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
      "Amoun Hotel",
      [
        'images/alexhotels/amoun1.jpg',
        'images/alexhotels/amoun2.jpg',
        'images/alexhotels/amoun3.jpg',
        'images/alexhotels/amoun4.jpg',
      ],
      "Hotels offer a temporary haven, providing comfort, convenience, and often a touch of luxury for travelers seeking respite from their journeys.",
      0),
  Hotel(
      "Green Plaza Inn",
      [
        'images/alexhotels/green1.jpg',
        'images/alexhotels/green2.jpg',
        'images/alexhotels/green3.jpg',
        'images/alexhotels/green4.jpg',
      ],
      "From opulent suites to cozy rooms, hotels offer a spectrum of accommodations to suit every taste and budget.",
      0),
  Hotel(
      'Hilton Alexandria Corniche',
      [
        'images/alexhotels/hilton1.jpg',
        'images/alexhotels/hilton2.jpg',
        'images/alexhotels/hilton3.jpg',
        'images/alexhotels/hilton4.jpg',
      ],
      "Hotels welcome weary travelers with open arms, offering a sanctuary where comfort meets convenience.",
      0),
  Hotel(
      'Royal Crown Hotel',
      [
        'images/alexhotels/royal1.jpg',
        'images/alexhotels/royal2.jpg',
        'images/alexhotels/royal3.jpg',
        'images/alexhotels/royal4.jpg',
      ],
      "Indulge in a world of comfort and luxury at our exquisite hotel, where every moment is crafted to exceed your expectations and leave you with cherished memories to last a lifetime",
      0),
  Hotel(
      'Semiramis Hotel',
      [
        'images/alexhotels/sim1.jpg',
        'images/alexhotels/sim2.jpg',
        'images/alexhotels/sim3.jpg',
        'images/alexhotels/sim4.jpg',
      ],
      "Experience the epitome of luxury and sophistication at Semirames Hotel, where timeless elegance meets modern comfort, creating an unforgettable oasis for discerning travelers.",
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
              MaterialPageRoute(builder: (context) => SecRoute()),
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
