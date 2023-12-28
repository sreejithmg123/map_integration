import 'package:flutter/material.dart';

class CustomGraph extends StatefulWidget {
  const CustomGraph({Key? key}) : super(key: key);

  @override
  State<CustomGraph> createState() => _CustomGraphState();
}

class _CustomGraphState extends State<CustomGraph> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Curved Graph using Custom Painter')),
        body: Center(
          child: SizedBox(
            width: 300,
            height: 200,
            child: CustomPaint(
              painter: CurvedGraphPainter(
                dataPoints: [
                  DataPoint(x: 0, y: 50),
                  DataPoint(x: 1, y: 80),
                  DataPoint(x: 2, y: 40),
                  DataPoint(x: 3, y: 120),
                  DataPoint(x: 4, y: 60),
                  DataPoint(x: 5, y: 90),
                ],
              ),
            ),
          ),
        ));
  }
}

class CurvedGraphPainter extends CustomPainter {
  final List<DataPoint> dataPoints;
  final double maxX;
  final double maxY;

  CurvedGraphPainter({required this.dataPoints})
      : maxX = dataPoints
            .map((point) => point.x)
            .reduce((value, element) => value > element ? value : element),
        maxY = dataPoints
            .map((point) => point.y)
            .reduce((value, element) => value > element ? value : element);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final path = Path();

    final scaleX = size.width / maxX;
    final scaleY = size.height / maxY;

    for (int i = 0; i < dataPoints.length - 1; i++) {
      final startX = dataPoints[i].x * scaleX;
      final startY = size.height - dataPoints[i].y * scaleY;

      final endX = dataPoints[i + 1].x * scaleX;
      final endY = size.height - dataPoints[i + 1].y * scaleY;

      final controlX = (startX + endX) / 2;
      final controlY = (startY + endY) / 2;

      if (i == 0) {
        path.moveTo(startX, startY);
      } else {
        path.quadraticBezierTo(controlX, controlY, endX, endY);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class DataPoint {
  final double x;
  final double y;

  DataPoint({required this.x, required this.y});
}
