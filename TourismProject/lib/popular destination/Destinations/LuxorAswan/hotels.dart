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
      "Hilton Luxor Resort & Spa",
      [
        'images/luxorandaswanhotels/hilt1.jpg',
        'images/luxorandaswanhotels/hilt2.jpg',
        'images/luxorandaswanhotels/hilt3.jpg',
        'images/luxorandaswanhotels/hilt4.jpg',
      ],
      "Hilton Luxor: Unrivaled luxury amidst ancient wonders.",
      0),
  Hotel(
      "Jewel Howard Carter Hotel",
      [
        'images/luxorandaswanhotels/jewel1.jpg',
        'images/luxorandaswanhotels/jewel2.jpg',
        'images/luxorandaswanhotels/jewel3.jpg',
        'images/luxorandaswanhotels/jewel4.jpg',
      ],
      "Jewel Howard: Monrovia's epitome of elegance and luxury.",
      0),
  Hotel(
      'New Memnon Hotel',
      [
        'images/luxorandaswanhotels/menmon1.jpg',
        'images/luxorandaswanhotels/menmon2.jpg',
        'images/luxorandaswanhotels/menmon3.jpg',
        'images/luxorandaswanhotels/menmon4.jpg',
      ],
      "Menmon Hotel: Your cozy urban retreat in the heart of the city.",
      0),
  Hotel(
      'Sonesta St. George Hotel',
      [
        'images/luxorandaswanhotels/sonesta1.jpg',
        'images/luxorandaswanhotels/sonesta2.jpg',
        'images/luxorandaswanhotels/sonesta3.jpg',
        'images/luxorandaswanhotels/sonesta4.jpg',
      ],
      "Sonesta Hotel: Modern elegance and warm hospitality await at our cozy urban retreat.",
      0),
  Hotel(
      'Steigenberger Nile Palace',
      [
        'images/luxorandaswanhotels/stein1.jpg',
        'images/luxorandaswanhotels/stein2.jpg',
        'images/luxorandaswanhotels/stein3.jpg',
        'images/luxorandaswanhotels/stein4.jpg',
      ],
      "Steigenburger Nile Hotel: Luxurious Nile-side charm awaits at our tranquil retreat.",
      0),

  Hotel(
      "Obelisk Nile Hotel",
      [
        'images/luxorandaswanhotels/ob1.jpg',
        'images/luxorandaswanhotels/ob2.jpg',
        'images/luxorandaswanhotels/ob3.jpg',
        'images/luxorandaswanhotels/ob4.jpg',
      ],
      "Obelisk Hotel: Where history and luxury converge, promising an unforgettable stay in the heart of the city.",
      0),
  Hotel(
      "Movenpick aswan",
      [
        'images/luxorandaswanhotels/moven11.jpg',
        'images/luxorandaswanhotels/moven2.jpg',
        'images/luxorandaswanhotels/moven3.jpg',
        'images/luxorandaswanhotels/moven4.jpg',
      ],
      "Mövenpick: Swiss hospitality, exotic charm, and unmatched comfort.",
      0),
  Hotel(
      'Sofitel Legend Old Cataract Aswan',
      [
        'images/luxorandaswanhotels/sof1.jpg',
        'images/luxorandaswanhotels/sof2.jpg',
        'images/luxorandaswanhotels/sof3.jpg',
        'images/luxorandaswanhotels/sof4.jpg',
      ],
      "Sofitel Hotel: A harmonious blend of sophistication and comfort awaits at our urban oasis.",
      0),
  Hotel(
      'Benben by Dhara hotel',
      [
        'images/luxorandaswanhotels/ben1.jpg',
        'images/luxorandaswanhotels/ben2.jpg',
        'images/luxorandaswanhotels/ben3.jpg',
        'images/luxorandaswanhotels/ben4.jpg',
      ],
      "Benben by Dhara Hotel: Urban elegance and warm hospitality await your arrival.",
      0),
  Hotel(
      'Pyramisa aswan hotel',
      [
        'images/luxorandaswanhotels/py1.jpg',
        'images/luxorandaswanhotels/py2.jpg',
        'images/luxorandaswanhotels/py3.jpg',
        'images/luxorandaswanhotels/py4.jpg',
      ],
      "Pyramisa Hotel: Your cozy urban retreat awaits.",
      0),
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
              MaterialPageRoute(builder: (context) => ThirdRoute()),
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
