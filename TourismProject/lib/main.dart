import 'package:flutter/material.dart';
import 'package:new_project/StartPages/home_page.dart';
import 'package:new_project/StartPages/log_in.dart';
import 'package:new_project/StartPages/start_page.dart';
import 'package:new_project/StartPages/favourite_page.dart';
import 'package:new_project/StartPages/mytrips_page.dart';
import 'package:new_project/StartPages/about_page.dart';
import 'package:new_project/StartPages/sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyBkrE1TxyOZo-BqQaCxe7XtAXGquFFf5bQ",
        appId: "1:783783765577:web:e5bd6545033c9882fa0198",
        messagingSenderId: "783783765577",
        projectId: "tourismproject-21995",
        // Your web Firebase config options
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(flutterproject());
}

class flutterproject extends StatelessWidget {
  const flutterproject({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "tourism guide",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFFE6969),
      ),
      home: Startpage(),
      initialRoute: 'startpage',
      routes: {
        'login': (context) => Login(),
        'homepage': (context) => Homepage(),
        //'favourite': (context) => Favourite(),
        // 'mytrips': (context) => Mytrips(),

        Favourite.screenRoute: (context) => Favourite(),
        Mytrips.screenRoute: (context) => Mytrips(),
        About.screenRoute: (context) => About(),
        Homepage.screenRoute: (context) => Homepage(),
        Signup.screenRoute: (context) => Signup(),
        Login.screenRoute: (context) => Login(),
      },
    );
  }
}
