import 'package:dependency_injection/hero_image.dart';
import 'package:dependency_injection/locale_provider.dart';
import 'package:dependency_injection/models/notes.dart';
import 'package:dependency_injection/notes_screen.dart';
import 'package:dependency_injection/seales_class/state_provider.dart';
import 'package:dependency_injection/ssembast_example.dart';

import 'package:dependency_injection/seales_class/state_screen.dart';
import 'package:drift/drift.dart';

import 'package:dependency_injection/services/firebase_api.dart';
import 'package:drift/native.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'custom_painter.dart';
import 'data.dart';

// import 'get_it.dart';
// import 'info_provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  // setUpLocator();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApiService().initNotifications();

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  final db = await SemDBExample().openDatabase(SemDBExample().notesDb);
  await SemDBExample().clearDatabase(db);
  // await SemDBExample().insertNote(
  //     Note(id: 1, title: 'title', content: 'content', isSelected: false), db);
  // await SemDBExample().insertNote(
  //     Note(id: 2, title: 'title', content: 'content', isSelected: false), db);
  // await SemDBExample().insertNote(
  //     Note(id: 3, title: 'title', content: 'content', isSelected: false), db);
  // final data = await SemDBExample().getData(db, 'key');
  //debugPrint(data);

  runApp(ChangeNotifierProvider(
      create: (context) => StateProvider(), child: MyApp()));
}

// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();
//
//   debugPrint("Handling a background message: ${message.messageId}");
// }

void timeConsumingTask(int value) {
  // Simulating a time-consuming task
  for (int i = 0; i < value; i++) {
    debugPrint('Processing: $i');
  }
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //ChangeNotifierProvider(create: (_) => InfoProvider()),
        ChangeNotifierProvider(create: (_) => StateProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        locale: context.watch<StateProvider>().locale ?? const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const StateScreen(),
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
