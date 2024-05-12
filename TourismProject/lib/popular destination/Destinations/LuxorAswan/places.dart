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
      "Colossi Of Memnon",
      [
        'images/luxorplaces/mon1.jpg',
        'images/luxorplaces/mon2.jpg',
        'images/luxorplaces/mon3.jpg',
        'images/luxorplaces/mon4.jpg',
      ],
      "The Colossi of Memnon: Majestic ancient statues in Luxor, Egypt, standing as guardians of the Theban necropolis.",
      0,
      false),
  Place(
      "Karnak",
      [
        'images/luxorplaces/kar1.jpg',
        'images/luxorplaces/kar2.jpg',
        'images/luxorplaces/kar3.jpg',
        'images/luxorplaces/kar4.jpg',
      ],
      "Karnak: A vast ancient temple complex in Luxor, Egypt, renowned for its impressive columns and rich history.",
      0,
      false),
  Place(
      'Luxor Temple',
      [
        'images/luxorplaces/lux1.jpg',
        'images/luxorplaces/lux2.jpg',
        'images/luxorplaces/lux3.jpg',
        'images/luxorplaces/lux4.jpg',
      ],
      "Luxor Temple: A magnificent ancient temple in Luxor, Egypt, known for its grandeur and historical significance.",
      0,
      false),
  Place(
      'Mummification Museum',
      [
        'images/luxorplaces/mom1.jpg',
        'images/luxorplaces/mom2.jpg',
        'images/luxorplaces/mom3.jpg',
        'images/luxorplaces/mom4.jpg',
      ],
      "The Mummification Museum in Luxor: a captivating showcase of ancient embalming practices.",
      0,
      false),
  Place(
      'Valley of the king',
      [
        'images/luxorplaces/val1.jpg',
        'images/luxorplaces/val2.jpg',
        'images/luxorplaces/val3.jpg',
        'images/luxorplaces/val4.jpg',
      ],
      "The Valley of the Kings: an ancient burial site in Luxor, Egypt, home to pharaohs' tombs.",
      0,
      false),

  Place(
      "Kom Ombo temple",
      [
        'images/luxorandaswanplaces/kom1.jpg',
        'images/luxorandaswanplaces/kom2.jpg',
        'images/luxorandaswanplaces/kom3.jpg',
        'images/luxorandaswanplaces/kom4.jpg',
      ],
      "Kom Ombo Temple: An ancient Egyptian temple dedicated to Sobek and Horus.",
      0,
      false),
  Place(
      "Nile Museum",
      [
        'images/luxorandaswanplaces/nil1.jpg',
        'images/luxorandaswanplaces/nil2.jpg',
        'images/luxorandaswanplaces/nil3.jpg',
        'images/luxorandaswanplaces/nil4.jpg',
      ],
      "The Nile Museum: A cultural institution celebrating the history and significance of the Nile River in Egypt.",
      0,
      false),
  Place(
      'Nubian Museum',
      [
        'images/luxorandaswanplaces/nub1.jpg',
        'images/luxorandaswanplaces/nub2.jpg',
        'images/luxorandaswanplaces/nub3.jpg',
        'images/luxorandaswanplaces/nub4.jpg',
      ],
      "The Nubian Museum: A cultural treasure in Aswan, Egypt, preserving the heritage and traditions of the Nubian people.",
      0,
      false),
  Place(
      'Nubian Village Aswan',
      [
        'images/luxorandaswanplaces/vi1.jpg',
        'images/luxorandaswanplaces/vi2.jpg',
        'images/luxorandaswanplaces/vi3.jpg',
        'images/luxorandaswanplaces/vi4.jpg',
      ],
      "The Nubian Village in Aswan: A vibrant community along the Nile, showcasing traditional Nubian culture and hospitality.",
      0,
      false),
  Place(
      'Unfinished Obliesk',
      [
        'images/luxorandaswanplaces/unf1.jpg',
        'images/luxorandaswanplaces/unf2.jpg',
        'images/luxorandaswanplaces/unf3.jpg',
        'images/luxorandaswanplaces/unf4.jpg',
      ],
      "The Unfinished Obelisk: A colossal ancient structure in Aswan, Egypt, revealing ancient construction techniques.",
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
              MaterialPageRoute(builder: (context) => ThirdRoute()),
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
