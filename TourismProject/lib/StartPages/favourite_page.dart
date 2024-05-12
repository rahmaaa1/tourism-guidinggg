import 'package:flutter/material.dart';
import 'package:new_project/widgets/app_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Favourite extends StatelessWidget {
  const Favourite({super.key});

  static const screenRoute = '/favourite';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite'),
      ),
      drawer: Appdrawer(),
    );
  }
}
