import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Place {
  final String name;
  final List<String> imagePaths;
  final String description;
  final int price;
  bool isFavorite;

  Place(this.name, this.imagePaths, this.description, this.price,
      this.isFavorite);
}

List<Place> places = [
  Place(
      "Ancient Roman Theater",
      [
        'images/alexplaces/an1.jpg',
        'images/alexplaces/an2.jpg',
        'images/alexplaces/an3.jpg',
        'images/alexplaces/an4.jpg',
      ],
      "The Ancient Roman Theater: a historic gem preserving ancient performances and culture.",
      0,
      false),
  Place(
      "Gerco-Roman Museum",
      [
        'images/alexplaces/geo1.jpg',
        'images/alexplaces/geo2.jpg',
        'images/alexplaces/geo3.jpg',
        'images/alexplaces/geo4.jpg',
      ],
      "The Greco-Roman Museum in Egypt preserves artifacts from its Hellenistic and Roman periods.",
      0,
      false),
  Place(
      'Montaza Palace',
      [
        'images/alexplaces/mon1.jpg',
        'images/alexplaces/mon2.jpg',
        'images/alexplaces/mon3.jpg',
        'images/alexplaces/mon4.jpg',
      ],
      "Montaza Palace: a charming seaside retreat in Alexandria, Egypt, with stunning gardens and regal architecture.",
      0,
      false),
  Place(
      'Royal Jewerly Museum',
      [
        'images/alexplaces/ro1.jpg',
        'images/alexplaces/ro2.jpg',
        'images/alexplaces/ro3.jpg',
        'images/alexplaces/ro4.jpg',
      ],
      "The Royal Jewelry Museum: a treasure trove of exquisite jewels and royal artifacts nestled in Alexandria, Egypt.",
      0,
      false),
  Place(
      'The Archaeological Museum',
      [
        'images/alexplaces/arch1.jpg',
        'images/alexplaces/arch2.jpg',
        'images/alexplaces/arch3.jpg',
        'images/alexplaces/arch4.jpg',
      ],
      "The Archaeological Museum: a repository of ancient artifacts and historical treasures.",
      0,
      false)
  // Add more hotels here
];

class ScreenThree extends StatefulWidget {
  ScreenThree({Key? key});

  @override
  State<ScreenThree> createState() => _ScreenThreeState();
}

class _ScreenThreeState extends State<ScreenThree> {
  List<Place> favoritePlaces = [];
  List<int> activeIndices = List.filled(places.length, 0);
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    getPlacesPrices();
  }

  void toggleFavoriteStatus(int index) {
    setState(() {
      places[index].isFavorite = !places[index].isFavorite;

      if (places[index].isFavorite) {
        favoritePlaces.add(places[index]);
      } else {
        favoritePlaces.remove(places[index]);
      }
    });
  }

  Future<void> getPlacesPrices() async {
    for (int i = 0; i < places.length; i++) {
      DocumentSnapshot document = await FirebaseFirestore.instance
          .collection('Touristic places')
          .doc(places[i].name)
          .get();
      if (document.exists) {
        int price = document.get('price');
        places[i] = Place(
          places[i].name,
          places[i].imagePaths,
          places[i].description,
          price,
          places[i].isFavorite,
        );
        if (price == null) {
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
              'Touristic',
              style: TextStyle(
                fontFamily: 'MadimiOne',
                color: Color.fromARGB(255, 121, 155, 230),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          for (int i = 0; i < places.length; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items: places[i]
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
                buildIndicator(activeIndices[i], places[i].imagePaths.length),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      SizedBox(width: 8),
                      Text(
                        places[i].name,
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
                          toggleFavoriteStatus(i);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(places[i].isFavorite
                                  ? 'Added to Favorites!'
                                  : 'Removed from Favorites!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Icon(
                          places[i].isFavorite
                              ? Icons.favorite
                              : Icons.favorite_outline,
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
                    places[i].description,
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
                      if (!isLoading && places[i].price != null)
                        Text(
                          places[i].price.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 5, 59, 107),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (!isLoading && places[i].price != null)
                        SizedBox(width: 8),
                      if (!isLoading && places[i].price != null)
                        Text(
                          "EGP",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 5, 59, 107),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (isLoading && places[i].price == null)
                        IconButton(
                          icon: Icon(Icons.cloud_download),
                          onPressed:
                              () {}, // Add the function to handle downloading here
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
