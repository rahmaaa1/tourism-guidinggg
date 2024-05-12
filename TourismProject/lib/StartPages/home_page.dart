//import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:new_project/models/emotios_face.dart';
import 'package:new_project/popular%20destination/home_view.dart';
import 'package:new_project/widgets/app_drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Homepage extends StatelessWidget {
  Homepage({Key? key}) : super(key: key);

  static const screenRoute = '/homepage';

  final List<String> urlImages = [
    'images/photo_2024-03-22_00-51-19.jpg',
    'images/photo_2024-03-22_00-51-21.jpg',
    'images/photo_2024-03-22_00-51-22.jpg',
    'images/photo_2024-03-22_00-51-25.jpg',
    'images/photo_2024-03-22_00-51-28.jpg',
  ];

  final List<String> urlImagesBottom = [
    'images/land1.jpg',
    'images/land2.jpg',
    'images/land3.jpg',
    'images/land4.jpg',
    'images/land5.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 121, 155, 228),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Home ",
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'MadimiOne',
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            Text(
              "Page",
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'MadimiOne',
                color: Color.fromARGB(255, 22, 23, 82),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      drawer: Appdrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 229, 234, 238),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "search",
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              SizedBox(height: 25),
              Text(
                'How Do You Feel ?',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 20,
                  fontFamily: 'MadimiOne',
                ),
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Emotionsface(
                        emotionsface: '😃',
                      ),
                      SizedBox(height: 8),
                      Text('Happy',
                          style: TextStyle(
                            color: Color.fromARGB(255, 22, 23, 82),
                            fontSize: 12,
                            fontFamily: 'MadimiOne',
                          ))
                    ],
                  ),
                  Column(
                    children: [
                      Emotionsface(
                        emotionsface: '😍',
                      ),
                      SizedBox(height: 8),
                      Text('Excited',
                          style: TextStyle(
                            color: Color.fromARGB(255, 22, 23, 82),
                            fontSize: 12,
                            fontFamily: 'MadimiOne',
                          ))
                    ],
                  ),
                  Column(
                    children: [
                      Emotionsface(
                        emotionsface: '🙂',
                      ),
                      SizedBox(height: 8),
                      Text('Fine',
                          style: TextStyle(
                            color: Color.fromARGB(255, 22, 23, 82),
                            fontSize: 12,
                            fontFamily: 'MadimiOne',
                          ))
                    ],
                  ),
                  Column(
                    children: [
                      Emotionsface(
                        emotionsface: '☹️',
                      ),
                      SizedBox(height: 8),
                      Text('Sad',
                          style: TextStyle(
                            color: Color.fromARGB(255, 22, 23, 82),
                            fontSize: 12,
                            fontFamily: 'MadimiOne',
                          ))
                    ],
                  ),
                ],
              ),
              SizedBox(height: 50),
              GestureDetector(onTap: () {
                 Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeView()));
              },
              child: Text(
                '➢Popular Destination',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 20,
                  fontFamily: 'MadimiOne',
                ),
              ),),
              CarouselSlider.builder(
                itemCount: urlImages.length,
                itemBuilder: (context, index, realIndex) {
                  final String imageUrl = urlImages[index];
                  return buildImage(imageUrl);
                },
                options: CarouselOptions(
                  height: 200,
                  viewportFraction: 1,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  reverse: true,
                  autoPlayInterval: Duration(seconds: 3),
                ),
              ),
              SizedBox(height: 40),
              Text(
                '➢Land Marks',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 20,
                  fontFamily: 'MadimiOne',
                ),
              ),
              CarouselSlider.builder(
                itemCount: urlImages.length,
                itemBuilder: (context, index, realIndex) {
                  final String imageUrl = urlImagesBottom[index];
                  return buildImage(imageUrl);
                },
                options: CarouselOptions(
                  height: 200,
                  viewportFraction: 1,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  reverse: true,
                  autoPlayInterval: Duration(seconds: 3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage(String url) => Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
            image: AssetImage(url),
            fit: BoxFit.cover,
          ),
        ),
      );
}
