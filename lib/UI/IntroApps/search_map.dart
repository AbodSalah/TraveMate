import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:hotelbooking/ShardFunction/handling.dart';
import 'package:hotelbooking/ShardFunction/statusrequst.dart';
import 'package:hotelbooking/UI/Bottom_Nav_Bar/bottomNavBar.dart';
import 'package:hotelbooking/UI/IntroApps/search/Data/constants.dart';
import 'package:hotelbooking/UI/IntroApps/search/Pages/map/map_page.dart';
import 'package:hotelbooking/UI/IntroApps/search/modssel.dart';
import 'package:hotelbooking/UI/IntroApps/travelSelection.dart';
import 'package:hotelbooking/UI/handlingView/handlingview.dart';

import 'dart:async';

import 'package:hotelbooking/data/functions_response/get_types.dart';
import 'package:hotelbooking/main.dart';

class SearchInMap extends StatefulWidget {
  @override
  _SearchInMapState createState() => _SearchInMapState();
}

class _SearchInMapState extends State<SearchInMap> {
  TextEditingController textsea = TextEditingController();
  String googleApikey = "AIzaSyANd3nsdL7bmOR-8UkZDrTNtjaX63JbjZs";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(27.6602292, 85.308027);
  String location = "Search Location";
  var position;
  SearchModde? modde;
  StatusRequest statusRequest = StatusRequest.none;

  getdataSearchTT(String searchtext) async {
    statusRequest = StatusRequest.loading;
    setState(() {});
    var response = await getSearchCityRespon(searchtext);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      try {
        modde = await SearchModde.fromJson(response);
        statusRequest = StatusRequest.none;
      } catch (e) {
        print('No data');
      }
    } else {
      print('erorr');
    }
    setState(() {});
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    position = determinePosition();

    super.initState();
  }

  Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("mp".tr),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 400,
              height: 60,
              child: TextField(
                onChanged: (value) {
                  getdataSearchTT(value);
                },
                decoration: InputDecoration(hintText: 'البحث ...'),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Divider(),

            Expanded(
              child: HandlingDataView(
                statusRequest: statusRequest,
                widget: ListView.builder(
                  itemCount: modde?.predictions?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: ListTile(
                        onTap: () async {
                          await sharedPreferences.setString(
                              'searcc',
                              modde?.predictions![index].placeId ??
                                  'ChIJl1ZCUPbgHBURhD0VvTCpC38');
                          // await getLocationFromPlaceId(
                          //     modde?.predictions![index].placeId ??
                          //         'ChIJl1ZCUPbgHBURhD0VvTCpC38');
                          Get.to(MapPage());
                        },
                        title: Text(
                          modde?.predictions![index].description.toString() ??
                              'hi',
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // GoogleMap(
            //   myLocationButtonEnabled: true,
            //   myLocationEnabled: true,
            //   //Map widget from google_maps_flutter package
            //   zoomGesturesEnabled: true, //enable Zoom in, out on map
            //   initialCameraPosition: CameraPosition(
            //     //innital position in map
            //     target: startLocation, //initial position
            //     zoom: 14.0, //initial zoom level
            //   ),
            //   mapType: MapType.normal, //map type
            //   onMapCreated: (controller) {
            //     //method called when map is created
            //     setState(() {
            //       mapController = controller;
            //     });
            //   },
            // ),
            //     Positioned(
            //       //search input bar
            //       top: 50,
            //       child: InkWell(
            //         onTap: () async {
            //           var place = await PlacesAutocomplete.show(
            //               context: context,
            //               apiKey: googleApikey,
            //               mode: Mode.overlay,
            //               types: [],
            //               strictbounds: true,
            //               components: [Component(Component.country, 'np')],
            //               //google_map_webservice package
            //               onError: (err) {
            //                 print(err);
            //               });
            //           print(place?.description.toString());
            //           print(']]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]');
            //           if (place != null) {
            //             setState(() {
            //               print(place.description.toString());
            //               print(']]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]');
            //               location = place.description.toString();
            //             });

            //             //form google_maps_webservice package
            //             final plist = GoogleMapsPlaces(
            //               apiKey: googleApikey,
            //               apiHeaders: await GoogleApiHeaders().getHeaders(),
            //               //from google_api_headers package
            //             );
            //             String placeid = place.placeId ?? "0";
            //             final detail = await plist.getDetailsByPlaceId(placeid);
            //             final geometry = detail.result.geometry!;
            //             final lat = geometry.location.lat;
            //             final lang = geometry.location.lng;
            //             var newlatlang = LatLng(lat, lang);

            //             //move map camera to selected place with animation
            //             mapController?.animateCamera(CameraUpdate.newCameraPosition(
            //                 CameraPosition(target: newlatlang, zoom: 17)));
            //           }
            //         },
            //         child: Padding(
            //           padding: EdgeInsets.all(15),
            //           child: Card(
            //             child: Container(
            //               padding: EdgeInsets.all(0),
            //               width: MediaQuery.of(context).size.width - 40,
            //               child: ListTile(
            //                 title: Text(
            //                   location,
            //                   style: TextStyle(fontSize: 18),
            //                 ),
            //                 trailing: Icon(Icons.search),
            //                 dense: true,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ));
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
