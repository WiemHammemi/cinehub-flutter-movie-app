
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MoviesApp());
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CinéHub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF1E1E2C),
        scaffoldBackgroundColor: const Color(0xFF15151F),
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFE50914),
          secondary: Color(0xFFF5C518),
          surface: Color(0xFF1E1E2C),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
