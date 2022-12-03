import 'dart:async';
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:customer/core/view/location_view.dart';
import 'package:customer/core/view/vendor_view.dart';
import 'package:customer/ui/main/map_screen/components/marker_widget.dart';
import 'package:customer/ui/main/vendor_detail_screen/vendor_detail_screen.dart';
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
    List<MarkerData> customMarkers = [];

    if (vendorView.vendors != null) {
      for (int i = 0; i < vendorView.vendors!.length; i++) {
        LatLng latLng = LatLng(vendorView.vendors![i].latitude, vendorView.vendors![i].longitude);
        customMarkers.add(
          MarkerData(
            marker: Marker(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (c) => VendorDetailScreen(
                        vendorModel: vendorView.vendors![i],
                      ),
                    ),
                  );
                },
                markerId: MarkerId(vendorView.vendors![i].vendorId),
                position: latLng),
            child: MarkerWidget(vendorModel: vendorView.vendors![i]),
          ),
        );
      }
    }

    return locationView.locationProcess == LocationProcess.idle
        ? (locationView.permission
            ? CustomGoogleMapMarkerBuilder(
                customMarkers: customMarkers,
                builder: (BuildContext context, Set<Marker>? markers) {
                  if (markers == null) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return GoogleMap(
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
                  );
                },
              )
            : const Center(
                child: Text("you must allow location services"),
              ))
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
