import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

// import 'package:location/location.dart';

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(15.1583353, 76.8802553),
    zoom: 14.4746,
  );
  // static final CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);
  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }

  // late LocationData currentLocation;

  // _getLocation() async {
  //   var location = Location();
  //   currentLocation = await location.getLocation();
  //   print("locationLatitude: ${currentLocation.latitude}");
  //   print("locationLongitude: ${currentLocation.longitude}");
  //   setState(() {});
  // }

  @override
  void initState() {
    //_getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: Material(
            color: Colors.transparent,
            shape: const CircleBorder(),
            clipBehavior: Clip.hardEdge,
            child: IconButton(
              icon: const FaIcon(FontAwesomeIcons.locationCrosshairs),
              onPressed: () {
                print("current location");
              },
            ),
          ),
        ),
      ],
    );
  }
}
