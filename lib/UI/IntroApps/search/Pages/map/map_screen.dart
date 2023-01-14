import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotelbooking/UI/B1_Home/B1_Home_Screen/B1_Home_Screen.dart';
import 'package:hotelbooking/UI/Bottom_Nav_Bar/bottomNavBar.dart';
import 'package:hotelbooking/UI/IntroApps/search/Data/constants.dart';
import 'package:hotelbooking/UI/IntroApps/search_map.dart';
import 'package:hotelbooking/UI/IntroApps/travelSelection.dart';
import 'package:hotelbooking/data/functions_response/get_info_room.dart';
import 'package:hotelbooking/main.dart';
import 'package:location/location.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';

import '../../Services/location_services.dart';
import '../../Services/polyline_services.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(31.768319, 35.213710),
    zoom: 14.4746,
  );

  LatLng currentLocation = _initialCameraPosition.target;

  BitmapDescriptor? _locationIcon;

  Set<Marker> _markers = {};

  Set<Polyline> _polylines = {};

  @override
  void initState() {
    getLocationFromPlaceId(sharedPreferences.getString('searcc')!);
    _buildMarkerFromAssets();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
              onTap: () {
                if (button1 == true) {
                  Navigator.of(context).pushReplacement(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new BottomNavBar(),
                      transitionDuration: const Duration(milliseconds: 600),
                      transitionsBuilder:
                          (_, Animation<double> animation, __, Widget child) {
                        return Opacity(
                          opacity: animation.value,
                          child: child,
                        );
                      }));
                } else if (button2 == true) {
                  Navigator.of(context).pushReplacement(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new BottomNavBar(),
                      transitionDuration: const Duration(milliseconds: 600),
                      transitionsBuilder:
                          (_, Animation<double> animation, __, Widget child) {
                        return Opacity(
                          opacity: animation.value,
                          child: child,
                        );
                      }));
                } else if (button3 == true) {
                  Navigator.of(context).pushReplacement(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new BottomNavBar(),
                      transitionDuration: const Duration(milliseconds: 600),
                      transitionsBuilder:
                          (_, Animation<double> animation, __, Widget child) {
                        return Opacity(
                          opacity: animation.value,
                          child: child,
                        );
                      }));
                } else if (button4 == true) {
                  Navigator.of(context).pushReplacement(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new BottomNavBar(),
                      transitionDuration: const Duration(milliseconds: 600),
                      transitionsBuilder:
                          (_, Animation<double> animation, __, Widget child) {
                        return Opacity(
                          opacity: animation.value,
                          child: child,
                        );
                      }));
                } else if (button5 == true) {
                  Navigator.of(context).pushReplacement(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new BottomNavBar(),
                      transitionDuration: const Duration(milliseconds: 600),
                      transitionsBuilder:
                          (_, Animation<double> animation, __, Widget child) {
                        return Opacity(
                          opacity: animation.value,
                          child: child,
                        );
                      }));
                } else if (button6 == true) {
                  Navigator.of(context).pushReplacement(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new BottomNavBar(),
                      transitionDuration: const Duration(milliseconds: 600),
                      transitionsBuilder:
                          (_, Animation<double> animation, __, Widget child) {
                        return Opacity(
                          opacity: animation.value,
                          child: child,
                        );
                      }));
                }
              },
              child: Icon(Icons.home)),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            initialCameraPosition: _initialCameraPosition,
            mapType: MapType.normal,
            onMapCreated: (controller) async {
              String style = await DefaultAssetBundle.of(context)
                  .loadString('assets/images/map_style.json');
              //customize your map style at: https://mapstyle.withgoogle.com/
              controller.setMapStyle(style);
              _controller.complete(controller);
            },
            onCameraMove: (e) => currentLocation = e.target,
            markers: _markers,
            polylines: _polylines,
          ),
          SizedBox(
            width: 40,
            height: 40,
            child: Image.asset('assets/images/location_icon.png'),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // FloatingActionButton(
                //   onPressed: () => _drawPolyline(
                //       LatLng(38.52900208591146, -98.54919254779816), currentLocation),
                //   child: Icon(Icons.settings_ethernet_rounded),
                // ),
                FloatingActionButton(
                  onPressed: () => _setMarker(currentLocation),
                  child: Icon(Icons.location_on),
                ),
                // FloatingActionButton(
                //   onPressed: () => _getMyLocation(),
                //   child: Icon(Icons.gps_fixed),
                // ),
              ],
            ),
          )
        ],
      ),

      // floatingActionButton: Column(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     // FloatingActionButton(
      //     //   onPressed: () => _drawPolyline(
      //     //       LatLng(38.52900208591146, -98.54919254779816), currentLocation),
      //     //   child: Icon(Icons.settings_ethernet_rounded),
      //     // ),
      //     FloatingActionButton(
      //       onPressed: () => _setMarker(currentLocation),
      //       child: Icon(Icons.location_on),
      //     ),
      //     // FloatingActionButton(
      //     //   onPressed: () => _getMyLocation(),
      //     //   child: Icon(Icons.gps_fixed),
      //     // ),
      //   ],
      // ),
      bottomNavigationBar: Container(
        height: 20,
        alignment: Alignment.center,
        child: Text(
            "lat: ${currentLocation.latitude}, long: ${currentLocation.longitude}"),
      ),
    );
  }

  Future<void> _drawPolyline(LatLng from, LatLng to) async {
    Polyline polyline = await PolylineService().drawPolyline(from, to);

    _polylines.add(polyline);

    _setMarker(from);
    _setMarker(to);

    setState(() {});
  }

  void _setMarker(LatLng _location) async {
    Marker newMarker = Marker(
      markerId: MarkerId(_location.toString()),
      icon: BitmapDescriptor.defaultMarker,
      // icon: _locationIcon,
      position: _location,
      infoWindow: InfoWindow(
          title: "Title",
          snippet: "${currentLocation.latitude}, ${currentLocation.longitude}"),
    );
    _markers.add(newMarker);
    await addSearchmapRespon(
      latitude: currentLocation.latitude,
      longitude: currentLocation.longitude,
    );
    setState(() {});
  }

  Future<void> _buildMarkerFromAssets() async {
    if (_locationIcon == null) {
      _locationIcon = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(48, 48)),
          'assets/images/location_icon.png');
      setState(() {});
    }
  }

  Future<void> _showSearchDialog() async {
    var p = await PlacesAutocomplete.show(
        context: context,
        apiKey: Constants.apiKey,
        mode: Mode.fullscreen,
        offset: 0,
        hint: "Type here...",
        radius: 1000,
        types: [],
        strictbounds: false,
        components: [Component(Component.country, "en")]);
    getLocationFromPlaceId(p!.placeId!);
  }

  Future<void> getLocationFromPlaceId(String placeId) async {
    GoogleMapsPlaces _places = GoogleMapsPlaces(
      apiKey: Constants.apiKey,
      apiHeaders: await GoogleApiHeaders().getHeaders(),
    );

    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(placeId);

    _animateCamera(LatLng(detail.result.geometry!.location.lat,
        detail.result.geometry!.location.lng));
  }

  Future<void> _getMyLocation() async {
    LocationData _myLocation = await LocationService().getLocation();
    _animateCamera(LatLng(_myLocation.latitude!, _myLocation.longitude!));
  }

  Future<void> _animateCamera(LatLng _location) async {
    final GoogleMapController controller = await _controller.future;
    CameraPosition _cameraPosition = CameraPosition(
      target: _location,
      zoom: 13.00,
    );
    print(
        "animating camera to (lat: ${_location.latitude}, long: ${_location.longitude}");
    controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
  }
}
