import 'package:flutter/material.dart';
import 'package:player/screens/main_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Player',
      theme: ThemeData.dark(),
      routes: {
        '/': (_) => MainPlayer(),
      },
    );
  }
}
