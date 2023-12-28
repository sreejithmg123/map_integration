import 'package:flutter/material.dart';

class PositionOfAWidget extends StatefulWidget {
  const PositionOfAWidget({Key? key}) : super(key: key);

  @override
  State<PositionOfAWidget> createState() => _PositionOfAWidgetState();
}

class _PositionOfAWidgetState extends State<PositionOfAWidget> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _widgetKey = GlobalKey();
  bool shouldAnimateToTop = false;

  void _checkAndAnimateToTop() {
    if (_widgetKey.currentContext != null) {
      final RenderBox box =
          _widgetKey.currentContext!.findRenderObject() as RenderBox;
      final Offset widgetPosition = box.localToGlobal(Offset.zero);
      final double offset = _scrollController.offset;

      if (offset >= widgetPosition.dy
          // &&
          // offset < widgetPosition.dy + box.size.height
          ) {
        setState(() {
          shouldAnimateToTop = true;
        });
        // _scrollController.animateTo(0,
        //     duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
      } else {
        setState(() {
          shouldAnimateToTop = false;
        });
      }
    }
  }

  @override
  void initState() {
    _scrollController.addListener(() => _checkAndAnimateToTop());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Position of Widgets Example')),
      body: Stack(
        children: [
          ListView(
            controller: _scrollController,
            children: [
              Container(
                color: Colors.red,
                height: 300,
              ),
              Container(
                color: Colors.cyan,
                height: 300,
              ),
              Container(
                color: Colors.green,
                height: 300,
              ),
              Container(
                key: _widgetKey,
                color: Colors.yellow,
                height: 300,
              ),
              Container(
                color: Colors.blue,
                height: 300,
              ),
            ],
          ),
          if (shouldAnimateToTop)
            Container(
              color: Colors.orange,
              height: 50,
            ),
        ],
      ),
    );
  }
}

class WidgetToTrack extends StatelessWidget {
  final String text;

  const WidgetToTrack({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      color: Colors.blue,
      width: 100,
      height: 100,
      child: Center(child: Text(text)),
    );
  }
}
