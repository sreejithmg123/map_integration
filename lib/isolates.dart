import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class Isolates extends StatefulWidget {
  const Isolates({Key? key}) : super(key: key);

  @override
  State<Isolates> createState() => _IsolatesState();
}

class _IsolatesState extends State<Isolates> {
  void startBackgroundTask() async {
    int value = 10000000;
    // Using compute to run timeConsumingTask in the background
    await compute(timeConsumingTask, value);
    debugPrint('Background Task Completed');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Background Task Example')),
        body: Center(
          child: ElevatedButton(
            onPressed: startBackgroundTask,
            child: const Text('Start Background Task'),
          ),
        ),
      ),
    );
  }
}
