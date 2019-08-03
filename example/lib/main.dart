import 'package:flutter/material.dart';
import 'package:sphere/sphere.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Sphere Demo',
      theme: ThemeData.dark(),
      home: MyHomePage(title: 'Flutter Sphere'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double latitude = 0;
  double longitude = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Sphere(
          surface: 'assets/2k_earth_daymap.jpg',
          radius: 180,
          latitude: latitude,
          longitude: longitude,
        ),
      ),
    );
  }
}
