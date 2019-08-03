import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sphere/sphere.dart';

void main() {
  testWidgets('sphere', (tester) async {
    await tester.pumpWidget(TestApp());
    expect(find.byType(Sphere), findsOneWidget);
  });
}

class TestApp extends StatefulWidget {
  @override
  _TestAppState createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Sphere(
          surface: '',
          radius: 300,
          latitude: 0,
          longitude: 0,
        ),
      ),
    );
  }
}
