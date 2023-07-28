import 'package:dependency_injection/info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback(
        (_) => context.read<InfoProvider>().checkLocationPermission());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Maps in Flutter')),
      body: WillPopScope(
        onWillPop: () async {
          if (!context.read<InfoProvider>().isButtonLoading) {
            Navigator.pop(context);
            return true;
          } else {
            debugPrint("can't pop");
            return false;
          }
        },
        child: Consumer<InfoProvider>(
          builder: (context, infoProvider, child) => infoProvider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                  children: [
                    GoogleMap(
                      onMapCreated: (controller) {
                        infoProvider.mapController = controller;
                      },
                      onCameraIdle: () {
                        debugPrint('camera move idle');
                        infoProvider.updateIsButtonLoading(false);
                      },
                      initialCameraPosition: CameraPosition(
                        target: infoProvider.currentPosition ??
                            const LatLng(37.7749,
                                -122.4194), // Default location (San Francisco)
                        zoom: 12.0, // Initial zoom level
                      ),
                      markers: infoProvider.markers,
                      onTap: infoProvider.handleTap,
                    ),
                    Positioned(
                      top: 20,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          placesAutoCompleteTextField(infoProvider)
                          // Container(
                          //   height: 40,
                          //   margin: const EdgeInsets.symmetric(horizontal: 20),
                          //   alignment: Alignment.center,
                          //   decoration: BoxDecoration(
                          //       color: Colors.white.withOpacity(.8),
                          //       borderRadius: BorderRadius.circular(10)),
                          //   padding: const EdgeInsets.symmetric(horizontal: 20),
                          //   child: TextField(
                          //     controller: infoProvider.textEditingController,
                          //     decoration: const InputDecoration(
                          //         hintText: 'Search for a location',
                          //         border: InputBorder.none),
                          //     onChanged: (value) =>
                          //         infoProvider.searchLocations(value),
                          //   ),
                          // ),
                          // if (infoProvider.mapDetailsList.isNotEmpty)
                          //   Container(
                          //     height: 150,
                          //     margin:
                          //         const EdgeInsets.symmetric(horizontal: 20),
                          //     color: Colors.white.withOpacity(.8),
                          //     child: ListView.builder(
                          //       shrinkWrap: true,
                          //       itemCount: infoProvider.mapDetailsList.length,
                          //       itemBuilder: (context, index) => ListTile(
                          //         title: Text(
                          //             infoProvider.mapDetailsList[index].name ??
                          //                 ''),
                          //         onTap: () {
                          //           FocusScope.of(context).unfocus();
                          //           infoProvider.getPlaceDetails(infoProvider
                          //                   .mapDetailsList[index].placeId ??
                          //               '');
                          //         },
                          //       ),
                          //     ),
                          //   )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                          height: 80,
                          color: Colors.green,
                          padding: const EdgeInsets.only(
                              left: 50, right: 50, top: 10),
                          child: Column(
                            children: [
                              Text(
                                infoProvider.locality ?? '',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              infoProvider.isButtonLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : InkWell(
                                      onTap: () => Navigator.pop(context),
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Text(
                                          'Update',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                            ],
                          )),
                    )
                  ],
                ),
        ),
      ),
    );
  }

  placesAutoCompleteTextField(InfoProvider infoProvider) {
    return Container(
      //padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(.8),
      ),

      child: GooglePlaceAutoCompleteTextField(
        textEditingController: infoProvider.textEditingController,
        boxDecoration: const BoxDecoration(
            border: Border.symmetric(
                horizontal: BorderSide.none, vertical: BorderSide.none)),
        googleAPIKey: infoProvider.apiKey,
        inputDecoration: const InputDecoration(
          hintText: "Search your location",
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
        debounceTime: 400,
        countries: ["in"],
        isLatLngRequired: false,
        itemClick: (Prediction prediction) {
          FocusScope.of(context).unfocus();
          infoProvider.getPlaceDetails(prediction.placeId ?? '');
        },
        seperatedBuilder: const Divider(),
        // OPTIONAL// If you want to customize list view item builder
        itemBuilder: (context, index, Prediction prediction) {
          return Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Icon(Icons.location_on),
                const SizedBox(
                  width: 7,
                ),
                Expanded(child: Text(prediction.description ?? ""))
              ],
            ),
          );
        },

        isCrossBtnShown: true,

        // default 600 ms ,
      ),
    );
  }
}
