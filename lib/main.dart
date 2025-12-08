import 'package:flutter/material.dart';
import 'package:flutter_hava_durumu/screens/home_page.dart';

void main() => runApp(const WeatherApp());

/// Main application widget
class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Türkiye Hava Durumu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
