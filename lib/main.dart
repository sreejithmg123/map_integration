import 'package:dependency_injection/get_it.dart';
import 'package:dependency_injection/home_screen.dart';
import 'package:dependency_injection/info_provider.dart';
import 'package:dependency_injection/info_service.dart';
import 'package:dependency_injection/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'info_provider.dart';

void main() {
  //setUpLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InfoProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//   final infoProvider = sl.get<InfoProvider>();
//   void _incrementCounter() {
//     infoProvider.updateValue();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final infoService = sl.get<InfoService>();
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Consumer<InfoProvider>(
//         builder: (context, provider, child) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Text(
//                   infoService.text,
//                 ),
//                 Text(
//                   infoProvider.i.toString(),
//                   style: Theme.of(context).textTheme.headlineMedium,
//                 )
//               ],
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
