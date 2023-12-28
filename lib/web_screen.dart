import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WebScreen extends StatefulWidget {
  const WebScreen({Key? key}) : super(key: key);

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  ScrollController scrollController = ScrollController();

  void _handleKeyPress(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        _scrollDown();
      } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        _scrollUp();
      } else if (event.logicalKey == LogicalKeyboardKey.pageDown) {
        _scrollPageDown();
      } else if (event.logicalKey == LogicalKeyboardKey.pageUp) {
        _scrollPageUp();
      }
    }
  }

  void _scrollDown() {
    scrollController.animateTo(
      scrollController.offset +
          400.0, // Adjust the value as per your desired scroll amount.
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  void _scrollUp() {
    scrollController.animateTo(
      scrollController.offset -
          100.0, // Adjust the value as per your desired scroll amount.
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  void _scrollPageDown() {
    scrollController.animateTo(
      scrollController.offset +
          400.0, // Adjust the value for the Page Down scroll amount.
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  void _scrollPageUp() {
    scrollController.animateTo(
      scrollController.offset -
          300.0, // Adjust the value for the Page Up scroll amount.
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RawKeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKey: (event) {
          _handleKeyPress(event);
        },
        child: SingleChildScrollView(
          controller: scrollController,
          child: ListView.builder(
            itemCount: 100,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => Text(' value $index'),
          ),
        ),
      ),
    );
  }
}

class ToolTipMessage extends StatefulWidget {
  const ToolTipMessage({Key? key}) : super(key: key);

  @override
  State<ToolTipMessage> createState() => _ToolTipMessageState();
}

class _ToolTipMessageState extends State<ToolTipMessage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tooltip in Side Sheet Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _openEndDrawer();
          },
          child: const Text('Open Side Sheet'),
        ),
      ),
      endDrawer: const SideSheet(), // Define the side sheet
    );
  }

  void _openEndDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }
}

class SideSheet extends StatelessWidget {
  const SideSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: const Text('Item with Tooltip'),
            onTap: () {
              // Handle item tap
            },
            trailing: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      constraints: const BoxConstraints(
                          maxWidth: 200), // Set your desired width
                      child: AlertDialog(
                        title: const Text('Tooltip'),
                        content: const Text(
                            'This is a custom tooltip message with a limited width.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Close'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: const Icon(Icons.info),
            ),
          ),
          // Other list items in the side sheet
          Container(
            height: 100,
            width: 100,
            color: Colors.red,
          ),
          Container(
            height: 100,
            width: 100,
            color: Colors.green,
          ),
          Container(
            height: 100,
            width: 100,
            color: Colors.cyan,
          ),
          Container(
            height: 100,
            width: 100,
            color: Colors.yellow,
          )
        ],
      ),
    );
  }
}
