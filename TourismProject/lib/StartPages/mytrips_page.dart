import 'package:flutter/material.dart';
import 'package:new_project/widgets/app_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Mytrips extends StatelessWidget {
  const Mytrips({super.key});

  static const screenRoute = '/mytrips';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Trips'),
      ),
      drawer: Appdrawer(),
    );
  }
}
