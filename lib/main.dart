import 'onboarding_page.dart';
import 'home_page.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final String title = 'QUIZZRR';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => CodeEntryPage(title: title),
        '/homeScreen': (context) => MyHomePage(title: title),
      },
    );
  }
}
