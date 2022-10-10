import 'dart:async';
import 'package:customer/core/view/location_view.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _controller;

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _controller = controller;
    String value =
    await DefaultAssetBundle.of(context).loadString('assets/map.json');
    _controller.setMapStyle(value);
  }

  @override
  Widget build(BuildContext context) {
    LocationView locationView = Provider.of<LocationView>(context);
    return locationView.position != null
        ? Stack(
      children: <Widget>[
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(
              locationView.position!.latitude,
              locationView.position!.longitude,
            ),
            zoom: 16,
          ),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          zoomControlsEnabled: false,
          //compassEnabled: true,
        ),
        locationView.locationProcess == LocationProcess.busy
            ? const Positioned(
          top: 0,
          bottom: 0,
          right: 0,
          left: 0,
          child: CircularProgressIndicator(),
        )
            : Container(),
      ],
    )
        : const Center(
      child: CircularProgressIndicator(),
    );

  }
}
