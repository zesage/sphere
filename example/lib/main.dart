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
  String surface = '2k_earth_daymap.jpg';
  final surfaces = [
    '2k_sun.jpg',
    '2k_mercury.jpg',
    '2k_venus_surface.jpg',
    '2k_earth_daymap.jpg',
    '2k_moon.jpg',
    '2k_mars.jpg',
    '2k_jupiter.jpg',
    '2k_saturn.jpg',
    '2k_uranus.jpg',
    '2k_neptune.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/2k_stars.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Sphere(
                  key: ValueKey(surface),
                  surface: 'assets/' + surface,
                  radius: 160,
                  latitude: 15,
                  longitude: 0,
                ),
              ),
            ),
            Container(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                itemExtent: 200,
                children: surfaces.map((item) {
                  return ListTile(
                    title: Column(
                      children: <Widget>[
                        Text(item),
                        Image.asset('assets/' + item),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        surface = item;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
