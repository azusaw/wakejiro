import 'package:flutter/material.dart';
import 'package:flutter_sample/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.cyan,
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.cyan,
      ),
      home: HomeScreen(),
    );
  }
}
