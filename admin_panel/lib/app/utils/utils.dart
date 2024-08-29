import 'package:admin_panel/app/modules/create_parking/controllers/create_parking_controller.dart';
import 'package:admin_panel/app/modules/parking_list/models/parking_model.dart';
import 'package:admin_panel/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

class Utils {
  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  static showPlacePicker(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return const LocationPicker();
        },
      ),
    );
  }
}

class LocationPicker extends StatelessWidget {
  const LocationPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FlutterLocationPicker(
      trackMyPosition: true,
      initZoom: 11,
      minZoomLevel: 5,
      maxZoomLevel: 16,
      initPosition: LatLong(Constant.currentLocation!.latitude, Constant.currentLocation!.longitude),
      searchBarBackgroundColor: Colors.white,
      selectedLocationButtonTextstyle: const TextStyle(fontSize: 18),
      mapLanguage: 'en',
      onError: (e) => debugPrint(e.toString()),
      onPicked: (pickedData) {
        CreateParkingController createParkingController = Get.put(CreateParkingController());
        createParkingController.locationLatLng.value =
            LocationLatLng(latitude: pickedData.latLong.latitude, longitude: pickedData.latLong.longitude);
        createParkingController.addressController.value.text = pickedData.address.toString();
        Get.back();
      },
    ));
  }
}
