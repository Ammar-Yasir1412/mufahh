import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class showMap extends StatelessWidget {
  const showMap({super.key});

  @override
  Widget build(BuildContext context) {
    LatLng _initialcameraposition = LatLng(31.573726, 73.4769454);
    late GoogleMapController _controller;
    final Location _location = Location();
    print("=======>ok");

    void _onMapCreated(GoogleMapController _cntlr) {
      _controller = _cntlr;
      _location.onLocationChanged.listen((l) {
        print("======<>>>$l");
        if (l.latitude != null && l.longitude != null) {
          _controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(l.latitude!, l.longitude!),
                zoom: 15,
              ),
            ),
          );
        } else {
          print("null value");
        }
      });
    }

    return Scaffold(
      body: Container(
        color: Colors.deepOrange,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(target: _initialcameraposition),
          mapType: MapType.normal,
          onMapCreated: _onMapCreated,
          myLocationEnabled: true,
        ),
      ),
    );
  }
}
