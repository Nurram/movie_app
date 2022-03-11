import 'package:flutter/material.dart';
import 'package:movie_app/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: _buildTheme(),
      home: const Home(),
    );
  }

  ThemeData _buildTheme() {
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(primary: Colors.red, secondary: Colors.redAccent[400]),
      scaffoldBackgroundColor: Colors.black87,
      textTheme: const TextTheme(
        headline5: TextStyle(
            color: Colors.white, overflow: TextOverflow.ellipsis),
        headline6: TextStyle(
            color: Colors.white, overflow: TextOverflow.ellipsis),
        bodyText1: TextStyle(color: Colors.white, overflow: TextOverflow.ellipsis),
      ),
    );
  }
}
