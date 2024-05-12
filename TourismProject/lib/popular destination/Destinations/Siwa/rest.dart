import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'info.dart';

class Rest {
  final String name;
  final List<String> imagePaths;
  final String description;
  bool isFavorite;

  Rest(this.name, this.imagePaths, this.description, this.isFavorite);
}

List<Rest> restaurants = [
  Rest(
      "Tekeyet Elamir",
      [
        'images/siwares/takia1.jpg',
        'images/siwares/takia2.jpg',
        'images/siwares/takia3.jpg',
        'images/siwares/takia4.jpg',
      ],
      "Tekeyet Elamir: A cozy spot in Egypt for traditional cuisine in a welcoming atmosphere.",
      false),
  Rest(
      "Nour El Waha Garden Restaurant",
      [
        'images/siwares/nor1.jpg',
        'images/siwares/nor2.jpg',
        'images/siwares/nor3.jpg',
        'images/siwares/nor4.jpg',
      ],
      "Nour El Waha Garden Restaurant: Egypt's oasis for delightful dining amidst lush greenery.",
      false),
  Rest(
      'Al-Babinshal',
      [
        'images/siwares/al4.jpg',
        'images/siwares/al3.jpg',
        'images/siwares/al2.jpg',
        'images/siwares/al1.jpg',
      ],
      "Al-Babinshal: Egypt's cozy spot for delicious dining.",
      false),
  Rest(
      'Joba Lounge',
      [
        'images/siwares/jo1.jpg',
        'images/siwares/jo2.jpg',
        'images/siwares/jo3.jpg',
        'images/siwares/jo4.jpg',
      ],
      "Joba Lounge: A chic and trendy spot in Egypt, perfect for enjoying cocktails and socializing in a stylish atmosphere.",
      false),
  Rest(
      "Abu Ayman",
      [
        'images/siwares/abo1.jpg',
        'images/siwares/abo2.jpg',
        'images/siwares/abo3.jpg',
      ],
      "Abu Ayman Restaurant: A beloved dining destination in Egypt, serving up delicious cuisine with a welcoming atmosphere, perfect for enjoying a meal with friends and family.",
      false)
  // Add more hotels here
];

class ScreenTwo extends StatefulWidget {
  ScreenTwo({Key? key});

  @override
  State<ScreenTwo> createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  List<Rest> favoriteRest = [];
  List<int> activeIndices = List.filled(restaurants.length, 0);
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  void toggleFavoriteStatus(int index) {
    setState(() {
      restaurants[index].isFavorite = !restaurants[index].isFavorite;

      if (restaurants[index].isFavorite) {
        favoriteRest.add(restaurants[index]);
      } else {
        favoriteRest.remove(restaurants[index]);
      }
    });
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
          for (int i = 0; i < restaurants.length; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items: restaurants[i]
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
                buildIndicator(
                    activeIndices[i], restaurants[i].imagePaths.length),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      SizedBox(width: 8),
                      Text(
                        restaurants[i].name,
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
                              content: Text(restaurants[i].isFavorite
                                  ? 'Added to Favorites!'
                                  : 'Removed from Favorites!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Icon(
                          restaurants[i].isFavorite
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: Color.fromARGB(255, 13, 16, 74),
                        ),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.menu_book_rounded,
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
                    restaurants[i].description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 36, 108, 163),
                      fontFamily: 'MadimiOne',
                    ),
                    textAlign: TextAlign.left,
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
