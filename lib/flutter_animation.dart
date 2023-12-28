import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FlutterAnimation extends StatefulWidget {
  const FlutterAnimation({Key? key}) : super(key: key);

  @override
  State<FlutterAnimation> createState() => _FlutterAnimationState();
}

class _FlutterAnimationState extends State<FlutterAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
                height: 60,
                child: Text(
                  "here's an interesting little trick, we can nest Animate to have",
                  style: TextStyle(color: Colors.white),
                )),
            const SizedBox(
                height: 60,
                child: Text(
                  "effects that repeat and ones that only run once on the same item:",
                  style: TextStyle(color: Colors.white),
                )),
            const SizedBox(
                height: 60,
                child: Text(
                  "Animate all of the info items in the list:",
                  style: TextStyle(color: Colors.white),
                )),
          ]
              .animate(interval: 600.ms)
              .fadeIn(duration: 900.ms, delay: 300.ms)
              .shimmer(blendMode: BlendMode.srcOver, color: Colors.white12)
              .move(begin: const Offset(-16, 0), curve: Curves.easeOutQuad)),
    );
  }
}
