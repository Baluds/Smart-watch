import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:smart_watch/model/model.dart';

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  late loc.LocationData _currentPosition;
  GoogleMapController? _controller;
  loc.Location location = loc.Location();
  LatLng _initialcameraposition = const LatLng(15.1583353, 76.8802553);

  getLoc() async {
    bool _serviceEnabled;
    loc.PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    _initialcameraposition =
        LatLng(_currentPosition.latitude!, _currentPosition.longitude!);
    location.onLocationChanged.listen((loc.LocationData currentLocation) {
      //print("${currentLocation.longitude} : ${currentLocation.longitude}");
      if (mounted) {
        setState(() {
          _currentPosition = currentLocation;
          _initialcameraposition =
              LatLng(_currentPosition.latitude!, _currentPosition.longitude!);
          _getAddress(_currentPosition.latitude!, _currentPosition.longitude!);
        });
      }
    });
  }

  void _getAddress(double lat, double lang) async {
    Model blueProvider = Provider.of<Model>(context, listen: false);
    late List<Placemark> placemarks;
    try {
      Future.delayed(const Duration(seconds: 1), () async {
        placemarks = await placemarkFromCoordinates(lat, lang);
        blueProvider.setAddress(placemarks[0]);
        //print(placemarks);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getLoc();
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _controller;
    location.onLocationChanged.listen((l) {
      _controller?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      myLocationEnabled: true,
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: _initialcameraposition,
        zoom: 14.4746,
      ),
      onMapCreated: _onMapCreated,
    );
  }
}
