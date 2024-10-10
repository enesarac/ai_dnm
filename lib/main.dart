import 'package:ai_dnm/pages/home_page.dart';
import 'package:flutter/material.dart';

void main () => runApp((new MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey,
        primaryColor: Colors.black,
      ),
    );
  }
}
