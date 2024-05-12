import 'package:flutter/material.dart';
import 'lib/popular destination/home_view.dart';

void main() {
  runApp(const PopDest());
}

class PopDest extends StatelessWidget {
  const PopDest({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeView(),
    );
  }
}
