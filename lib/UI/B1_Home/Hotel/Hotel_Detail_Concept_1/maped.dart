import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotelbooking/main.dart';

class MapEdit extends StatefulWidget {
  const MapEdit({
    super.key,
  });

  @override
  State<MapEdit> createState() => _MapEditState();
}

class _MapEditState extends State<MapEdit> {
  CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(sharedPreferences.getDouble('lat')!,
        sharedPreferences.getDouble('lan')!),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        initialCameraPosition: _initialCameraPosition,
        mapType: MapType.normal,
        onMapCreated: (controller) async {
          String style = await DefaultAssetBundle.of(context)
              .loadString('assets/images/map_style.json');
          //customize your map style at: https://mapstyle.withgoogle.com/
          controller.setMapStyle(style);
        },
        // onCameraMove: (e) => currentLocation = e.target,
      ),
    );
  }
}
