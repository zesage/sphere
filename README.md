# Sphere

[![pub package](https://img.shields.io/pub/v/sphere.svg)](https://pub.dev/packages/sphere)

A sphere widget for Flutter.

## Getting Started

Add sphere as a dependency in your pubspec.yaml file.

```yaml
dependencies:
  sphere: ^0.0.4
```

## Usage example

Add an image assets to your pubspec.yaml file.

```yaml
  assets:
    - assets/2k_earth_daymap.jpg
```

Import sphere.dart and add sphere widget to your app.


```dart
import 'package:sphere/sphere.dart';
... ...
  
@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Sphere(
          surface: 'assets/2k_earth_daymap.jpg',
          radius: 180,
          latitude: 0,
          longitude: 0,
        ),
      ),
    );
  }
```