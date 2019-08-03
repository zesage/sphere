library sphere;

import 'dart:async';
import 'dart:typed_data';
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart' show rootBundle;

class Sphere extends StatefulWidget {
  Sphere({this.surface, this.radius, this.latitude, this.longitude});
  final String surface;
  final double radius;
  final double latitude;
  final double longitude;

  @override
  _SphereState createState() => _SphereState();
}

class _SphereState extends State<Sphere> {
  Uint32List surface;
  double surfaceWidth;
  double surfaceHeight;

  Future<ui.Image> buildSphere() {
    if (surface == null) return null;
    final r = widget.radius;
    final minX = -r;
    final minY = -r;
    final maxX = r;
    final maxY = r;
    final width = maxX - minX;
    final height = maxY - minY;
    final sphere = Uint32List(width.toInt() * height.toInt());

    for (var y = minY; y < maxY; y++) {
      for (var x = minX; x < maxX; x++) {
        var z = r * r - x * x - y * y;
        if (z > 0) {
          z = math.sqrt(z);

          var x1 = x, y1 = y, z1 = z;
          double x2, y2, z2;
          //rotate around the X axis
          var angle = math.pi / 2 - widget.latitude * math.pi / 180;
          y2 = y1 * math.cos(angle) - z1 * math.sin(angle);
          z2 = y1 * math.sin(angle) + z1 * math.cos(angle);
          y1 = y2;
          z1 = z2;
          //rotate around the Y axis
          // angle = 0;
          // x2 = x1 * math.cos(angle) + z1 * math.sin(angle);
          // z2 = -x1 * math.sin(angle) + z1 * math.cos(angle);
          // x1 = x2;
          // z1 = z2;
          //rotate around the Z axis
          angle = widget.longitude * math.pi / 180 + math.pi / 2;
          x2 = x1 * math.cos(angle) - y1 * math.sin(angle);
          y2 = x1 * math.sin(angle) + y1 * math.cos(angle);
          x1 = x2;
          y1 = y2;

          final lat = math.asin(z1 / r);
          final lon = math.atan2(y1, x1);

          final x0 = (0.5 + lon / (2.0 * math.pi)) * (surfaceWidth - 1);
          final y0 = (0.5 - lat / math.pi) * (surfaceHeight - 1);

          final color = surface[y0.round() * surfaceWidth.toInt() + x0.round()];
          sphere[((-y - minY - 1) * width + x - minX).toInt()] = color;
        }
      }
    }

    final c = Completer<ui.Image>();
    ui.decodeImageFromPixels(
      sphere.buffer.asUint8List(),
      width.toInt(),
      height.toInt(),
      ui.PixelFormat.rgba8888,
      (image) => c.complete(image),
    );
    return c.future;
  }

  void loadSurface() {
    rootBundle.load(widget.surface).then((data) {
      ui.decodeImageFromList(data.buffer.asUint8List(), (image) {
        image.toByteData(format: ui.ImageByteFormat.rawRgba).then((pixels) {
          surface = pixels.buffer.asUint32List();
          surfaceWidth = image.width.toDouble();
          surfaceHeight = image.height.toDouble();
          setState(() {});
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadSurface();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: buildSphere(),
      builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
        return CustomPaint(
          painter: SpherePainter(image: snapshot.data, radius: widget.radius),
          size: Size(widget.radius * 2, widget.radius * 2),
        );
      },
    );
  }
}

class SpherePainter extends CustomPainter {
  SpherePainter({this.image, this.radius});
  final ui.Image image;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    if (image == null) return;
    final paint = Paint();
    final offset = Offset(size.width / 2, size.height / 2);
    final rect = Rect.fromCircle(center: offset, radius: radius - 1);
    final path = Path()..addOval(rect);
    canvas.clipPath(path);
    canvas.drawImage(image, offset - Offset(radius, radius), paint);

    final gradient = RadialGradient(
      center: Alignment.center,
      colors: [Colors.transparent, Colors.black.withOpacity(0.35), Colors.black.withOpacity(0.5)],
      stops: [0.1, 0.85, 1.0],
    );
    paint.shader = gradient.createShader(rect);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
