import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

class InfoProvider with ChangeNotifier {
  int i = 0;
  LatLng? currentPosition;
  bool isLoading = false;
  bool isButtonLoading = false;
  GoogleMapController? mapController;
  final Set<Marker> markers = {};
  LatLng? tappedLocation;

  String? name; // Name of the location (if available)
  String? street; // Street address
  String? locality; // City
  String? postalCode; // Postal code
  String? country; // Country

  TextEditingController textEditingController = TextEditingController();
  final String apiKey = 'AIzaSyCURhJrCUlMT5LJYktdu2_2NCSPMO8eh10';
  List<MapDetails> mapDetailsList = [];
  updateValue() {
    i = i + 1;
    debugPrint(i.toString());
    notifyListeners();
  }

  updateIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  updateIsButtonLoading(bool value) {
    isButtonLoading = value;
    notifyListeners();
  }

  updateCurrentPosition(LatLng position, {bool? isUpdateButtonLoading}) async {
    currentPosition = position;
    await getLocationFromLatLng(position);
    updateIsLoading(false);
    if ((isUpdateButtonLoading ?? true)) updateIsButtonLoading(false);
    notifyListeners();
  }

  void getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    updateCurrentPosition(LatLng(position.latitude, position.longitude));
  }

  Future<void> checkLocationPermission() async {
    updateIsLoading(true);
    PermissionStatus permission = await Permission.location.status;
    if (permission.isDenied) {
      await Permission.location.request();
    }
    if (currentPosition == null) {
      getCurrentLocation();
    } else {
      updateCurrentPosition(currentPosition!);
    }
  }

  void handleTap(LatLng tappedPoint) {
    tappedLocation = tappedPoint;
    currentPosition = tappedPoint;
    markers.clear(); // Clear existing markers
    markers.add(
      Marker(
        markerId: MarkerId(tappedPoint.toString()),
        position: tappedPoint,
        infoWindow: InfoWindow(
          title: 'Marker',
          snippet:
              'Lat: ${tappedPoint.latitude}, Lng: ${tappedPoint.longitude}',
        ),
      ),
    );
    // Get location details from the tapped coordinates using reverse geocoding
    getLocationFromLatLng(tappedPoint);
    // Center the map on the tapped location
    mapController?.animateCamera(
      CameraUpdate.newLatLng(tappedPoint),
    );
    notifyListeners();
  }

  // Get location details from the tapped coordinates using reverse geocoding
  getLocationFromLatLng(LatLng tappedPoint) async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(
      tappedPoint.latitude,
      tappedPoint.longitude,
    );

    // Extract location details from the first Placemark in the list
    if (placeMarks.isNotEmpty) {
      Placemark placeMarkFirst = placeMarks.first;
      name = placeMarkFirst.name; // Name of the location (if available)
      street = placeMarkFirst.street; // Street address
      locality = placeMarkFirst.locality; // City
      postalCode = placeMarkFirst.postalCode; // Postal code
      country = placeMarkFirst.country; // Country
    }
    notifyListeners();
  }

  void searchLocations(String query) async {
    if (query.isNotEmpty) {
      String url =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=$apiKey';
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List predictions = json.decode(response.body)['predictions'];
        mapDetailsList.clear();
        for (int i = 0; i < predictions.length; i++) {
          mapDetailsList.add(MapDetails(
              name: predictions[i]['description'],
              placeId: predictions[i]['place_id']));
        }
      }
      notifyListeners();
    }
  }

  Future<void> getPlaceDetails(String placeId) async {
    updateIsButtonLoading(true);
    String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map data = json.decode(response.body)['result'];
      double lat = data['geometry']['location']['lat'];
      double lng = data['geometry']['location']['lng'];
      markers.clear();
      markers.add(
        Marker(
          markerId: MarkerId(placeId),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(
            title: name,
            snippet: name,
          ),
        ),
      );
      await mapController
          ?.animateCamera(CameraUpdate.newLatLng(LatLng(lat, lng)));
      await updateCurrentPosition(LatLng(lat, lng),
          isUpdateButtonLoading: false);
      mapDetailsList.clear();
    }
    notifyListeners();
  }

  clearValues() {
    markers.clear();
    textEditingController.clear();
    mapDetailsList.clear();
  }
}

class MapDetails {
  String? name;
  String? placeId;
  MapDetails({this.name, this.placeId});
}
