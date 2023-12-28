import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class MyCustomPainterScreen extends StatefulWidget {
  const MyCustomPainterScreen({Key? key}) : super(key: key);

  @override
  State<MyCustomPainterScreen> createState() => _MyCustomPainterScreenState();
}

class _MyCustomPainterScreenState extends State<MyCustomPainterScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MyCustomPaintWidget(),
    );
  }
}

class MyCustomPaintWidget extends StatelessWidget {
  const MyCustomPaintWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyCustomPainter(),
      child: Container(
        height: 200,
        width: 200,
        // alignment: Alignment.center,
        // child: Text('Test'),
      ),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 3;

    const startAngle = -pi / 4; // Angle in radians
    const endAngle = pi / 2; // Angle in radians
    const useCenter = false; // Set to true to close the arc
    final rect = Rect.fromLTWH(50, 50, size.width - 100, size.height - 100);

    final outerRadius = BorderRadius.circular(20);
    final innerRadius = BorderRadius.circular(40);

    final outerRRect = RRect.fromRectAndCorners(rect,
        topLeft: outerRadius.topLeft,
        topRight: outerRadius.topRight,
        bottomLeft: outerRadius.bottomLeft,
        bottomRight: outerRadius.bottomRight);

    final innerRRect = RRect.fromRectAndCorners(rect.deflate(20),
        topLeft: innerRadius.topLeft,
        topRight: innerRadius.topRight,
        bottomLeft: innerRadius.bottomLeft,
        bottomRight: innerRadius.bottomRight);

    final points = [
      const Offset(50, 50),
      const Offset(150, 100),
      const Offset(200, 150),
      const Offset(100, 200),
      const Offset(200, 400),
    ];

    ///draw arc
    // final paint = Paint()
    //   ..color = Colors.blue
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 4.0;
    // canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
    //     endAngle - startAngle, useCenter, paint);

    ///draw circle
    // final paint = Paint()..color = Colors.blue;
    // canvas.drawCircle(center, radius, paint);

    ///draw DRRect
    // final paint = Paint()
    //   ..color = Colors.blue
    //   ..style = PaintingStyle.fill;
    // canvas.drawDRRect(outerRRect, innerRRect, paint);

    ///draw points
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round;

    canvas.drawPoints(PointMode.points, points, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
