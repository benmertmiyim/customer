import 'dart:async';
import 'package:customer/core/view/location_view.dart';
import 'package:customer/core/view/vendor_view.dart';
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
  final Set<Marker> markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _controller = controller;
    String value =
        await DefaultAssetBundle.of(context).loadString('assets/map.json');
    _controller.setMapStyle(value);
  }

  @override
  Widget build(BuildContext context) {
    LocationView locationView = Provider.of<LocationView>(context);
    VendorView vendorView = Provider.of<VendorView>(context);

    if(vendorView.vendors != null){
      markers.add(Marker( //add first marker
        markerId: MarkerId("showLocation.toString()"),
        position: vendorView.vendors![0].location, //position of marker
        infoWindow: InfoWindow( //popup info
          title: 'My Custom Title ',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));
      markers.add(Marker( //add first marker
        markerId: MarkerId("showation.toString()"),
        position: vendorView.vendors![1].location, //position of marker
        infoWindow: InfoWindow( //popup info
          title: 'My Custom Title ',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));
    }
    
    return locationView.locationProcess == LocationProcess.idle
        ? (locationView.permission
            ? GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    locationView.position!.latitude,
                    locationView.position!.longitude,
                  ),
                  zoom: 16,
                ),
                markers: markers,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                zoomControlsEnabled: false,
                //compassEnabled: true,
              )
            : const Center(
                child: Text("you must allow location services"),
              ))
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
