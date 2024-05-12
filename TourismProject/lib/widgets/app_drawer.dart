import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_project/StartPages/favourite_page.dart';
import 'package:new_project/StartPages/mytrips_page.dart';
import 'package:new_project/StartPages/about_page.dart';
import 'package:new_project/StartPages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:new_project/StartPages/log_in.dart';

//import:'package:flutter/src/widgets/navigator.dart';
class Appdrawer extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Widget newMethod(String title, IconData icon, onTapLink) {
    return ListTile(
      leading: Icon(
        icon,
        size: 15,
        color: Colors.blue,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'MadimiOne',
          color: Color.fromARGB(255, 22, 23, 82),
        ),
      ),
      onTap: onTapLink,
    );
  }

  Future<String> _getUsername(String userId) async {
    String username = '';
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('Usere').doc(userId).get();
      if (userDoc.exists) {
        username = userDoc['username'];
      }
    } catch (e) {
      print('Error retrieving username: $e');
    }
    return username;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(children: [
      Container(
          height: 75,
          width: double.infinity,
          padding: EdgeInsets.only(top: 40),
          alignment: Alignment.center,
          color: Color.fromARGB(255, 121, 155, 228),
          child: Text(
            'OTHERS',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'MadimiOne',
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 22, 23, 82),
            ),
          )),
      SizedBox(height: 15),
      Container(
        child: Column(
          children: [
            FutureBuilder<String>(
              future: _getUsername(FirebaseAuth.instance.currentUser!.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  String username = snapshot.data ?? '';
                  return ListTile(
                    leading: CircleAvatar(
                      child: Icon(
                        CupertinoIcons.person,
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.blue,
                    ),
                    title: Text(
                      '$username',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'MadimiOne',
                        color: Color.fromARGB(255, 22, 23, 82),
                      ),
                    ),
                  );
                }
              },
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 35),
                  child: Divider(
                    color: const Color.fromARGB(101, 158, 158, 158),
                    height: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      SizedBox(height: 17),
      newMethod(
        'Home Page',
        Icons.home,
        () {
          Navigator.of(context).pushReplacementNamed(Homepage.screenRoute);
        },
      ),
      newMethod(
        'Favourite ♡',
        Icons.heat_pump_rounded,
        () {
          Navigator.of(context).pushReplacementNamed(Favourite.screenRoute);
        },
      ),
      newMethod(
        'My Trips +',
        Icons.card_travel_rounded,
        () {
          Navigator.of(context).pushReplacementNamed(Mytrips.screenRoute);
        },
      ),
      newMethod(
        'About',
        Icons.arrow_forward_sharp,
        () {
          Navigator.of(context).pushReplacementNamed(About.screenRoute);
        },
      ),
      SizedBox(
        height: 450,
      ),
      newMethod('Log Out', Icons.logout, () async {
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.remove('email');
        Navigator.of(context).pushReplacementNamed(Login.screenRoute);
      })
    ]));
  }
}
