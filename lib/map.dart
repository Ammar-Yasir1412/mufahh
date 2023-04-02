import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

_getLocation() async {
  print("2=========>");

                
  await Permission.location.request();

var geolocationStatus = await 
Geolocator.checkPermission();
 print("=========>$geolocationStatus");
Position position = await Geolocator
    .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
debugPrint('location: ${position.latitude}');


final coordinates = new Coordinates(position.latitude, position.longitude);
debugPrint('coordinates is: $coordinates');
var addressesURL =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);
var addresses =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);
var first = addresses.first;
// print number of retured addresses 
debugPrint('${addresses.length}');
// print the best address
debugPrint("best address===>${first.featureName} :===> ${first.addressLine}");
//print other address names
debugPrint("Country:${first.countryName} AdminArea:${first.adminArea} SubAdminArea:${first.subAdminArea}");
// print more address names
debugPrint("Locality:${first.locality}: Sublocality:${first.subLocality}");
}
