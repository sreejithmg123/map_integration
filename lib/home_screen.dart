import 'package:dependency_injection/info_provider.dart';
import 'package:dependency_injection/map_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<InfoProvider>(
        builder: (context, infoProvider, child) => Stack(
          children: [
            Positioned(
              top: 150,
              left: 40,
              right: 40,
              child: Center(
                  child: Column(
                children: [
                  Text(
                      'Position ${infoProvider.currentPosition?.latitude}  ${infoProvider.currentPosition?.longitude}'),
                  Text('Name of the location ${infoProvider.name}'),
                  Text('Street ${infoProvider.street}'),
                  Text('Locality ${infoProvider.locality}'),
                  Text('Postal code ${infoProvider.postalCode}'),
                  Text('Country ${infoProvider.country}'),
                ],
              )),
            ),
            Positioned(
              bottom: 40,
              right: 0,
              left: 0,
              child: TextButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MapScreen())).then(
                      (value) => context.read<InfoProvider>().clearValues()),
                  child: const Text('Go to map screen')),
            )
          ],
        ),
      ),
    );
  }
}
