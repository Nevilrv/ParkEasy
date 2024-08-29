import 'dart:developer';
import 'dart:io';

import 'package:admin_panel/app/modules/facilities/models/facilities_model.dart';
import 'package:admin_panel/app/modules/facilities/views/facilities_view.dart';
import 'package:admin_panel/app/modules/parking_list/models/parking_model.dart';
import 'package:admin_panel/app/modules/parking_list/views/parking_list_view.dart';
import 'package:admin_panel/app/modules/parking_owners/models/parking_owner_model.dart';
import 'package:admin_panel/app/services/firebase/facilities_firebase_requests.dart';
import 'package:admin_panel/app/services/firebase/parking_firebase_request.dart';
import 'package:admin_panel/app/services/firebase/parking_owner_firebase_requests.dart';
import 'package:admin_panel/app/utils/const.dart';
import 'package:admin_panel/app/utils/constants.dart';
import 'package:admin_panel/app/utils/utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateParkingController extends GetxController {
  Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;

  Rx<TextEditingController> parkingNameController = TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;
  Rx<TextEditingController> parkingSpaceController = TextEditingController().obs;
  Rx<TextEditingController> priceController = TextEditingController().obs;
  Rx<TextEditingController> startTimeController = TextEditingController().obs;
  Rx<TextEditingController> endTimeController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;
  Rx<TextEditingController> imageController = TextEditingController().obs;
  Rx<TextEditingController> selectedOwnerNameController = TextEditingController().obs;
  RxString selectedOwnerId = "".obs;
  RxString selectedOwnerName = "".obs;

  Rx<Status> isActive = Status.active.obs;
  RxString parkingType = "2".obs;
  RxString countryCode = "+91".obs;
  RxList<FacilitiesModel> parkingFacilitiesList = <FacilitiesModel>[].obs;
  RxList<FacilitiesModel> selectedParkingFacilitiesList = <FacilitiesModel>[].obs;

  RxBool parkingStatus = true.obs;

  RxList<ParkingOwnerModel> ownerList = <ParkingOwnerModel>[].obs;
  Rx<ParkingOwnerModel> parkingOwnerModel = ParkingOwnerModel().obs;

  getData() async {
    await getParkingOwner().then((value) {
      ownerList.value = value;
    });
    await getFacilities().then((value) {
      parkingFacilitiesList.value = value;
    });
  }

  @override
  void onInit() {
    getData();
    getLocation();
    super.onInit();
  }

  void handleParkingChange(String? value) {
    parkingType.value = value!;
  }

  RxList<XFile>? parkingImages = <XFile>[].obs;
  RxList<String>? parkingImagesList = <String>[].obs;
  Rx<File> imageFile = File('').obs;
  RxString imageURL = "".obs;
  Rx<LocationLatLng> locationLatLng = LocationLatLng().obs;
  Rx<ParkingModel> parkingModel = ParkingModel().obs;

  pickMultiImages() async {
    final imagePicker = ImagePicker();

    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      parkingImages!.addAll(selectedImages);
      for (var image in selectedImages) {
        parkingImagesList!.add(image.name);
      }
      log("image : $parkingImagesList");
      imageController.value.text = parkingImagesList!.toString();
    }
  }

  Future<List<String>> uploadImageToFireStorage(List<XFile> images) async {
    var imageUrls =
        await Future.wait(images.map((image) => uploadFile(image, "parkingImages/$selectedOwnerId", image.path.split("/").last)));
    return imageUrls;
  }

  Future<String> uploadFile(XFile image, String filePath, String fileName) async {
    Reference ref = FirebaseStorage.instance.ref().child('$filePath/$fileName');
    UploadTask uploadTask;
    uploadTask = ref.putData(
        await image.readAsBytes(),
        SettableMetadata(
          contentType: "image/png",
          customMetadata: {'picked-file-path': image.path},
        ));
    var downloadUrl = await (await uploadTask.whenComplete(() {})).ref.getDownloadURL();
    return downloadUrl.toString();
  }

  saveDetails() async {
    ProgressLoader.showLoadingDialog();

    String docId = getRandomString(20);
    if (parkingModel.value.id == null || parkingModel.value.ownerId == null) {
      parkingModel.value.id = docId;
      parkingModel.value.ownerId = selectedOwnerId.value;
    }
    if (parkingImages!.isNotEmpty) {
      List<String> downloadUrl = await uploadImageToFireStorage(
        parkingImages!,
      );
      parkingModel.value.images = downloadUrl;
    }

    parkingModel.value.parkingName = parkingNameController.value.text;
    parkingModel.value.address = addressController.value.text;
    parkingModel.value.parkingType = parkingType.value;
    parkingModel.value.parkingSpace = parkingSpaceController.value.text;
    parkingModel.value.location = locationLatLng.value;
    parkingModel.value.perHrRate = priceController.value.text;
    parkingModel.value.active = isActive.value.name == Status.active.name ? true : false;
    parkingModel.value.startTime = startTimeController.value.text;
    parkingModel.value.facilities = selectedParkingFacilitiesList;
    parkingModel.value.countryCode = countryCode.value;
    parkingModel.value.phoneNumber = phoneNumberController.value.text;
    parkingModel.value.endTime = endTimeController.value.text;
    GeoFirePoint position = GeoFlutterFire().point(latitude: locationLatLng.value.latitude!, longitude: locationLatLng.value.longitude!);
    parkingModel.value.position = Positions(geoPoint: position.geoPoint, geohash: position.hash);

    await addParking(parkingModel.value).then((value) {
      parkingNameController.value.clear();
      addressController.value.clear();
      parkingType.value = "2";
      parkingSpaceController.value.clear();
      priceController.value.clear();
      isActive.value = Status.active;
      startTimeController.value.clear();
      selectedParkingFacilitiesList.clear();
      countryCode.value = "+91";
      phoneNumberController.value.clear();
      endTimeController.value.clear();
      parkingImagesList!.clear();
      selectedOwnerId.value = "";
      Get.back(result: true);
      Get.back();
      parkingListController.getData();
      showSuccessToast("Parking Information save");
    });
  }

  getLocation() async {
    Constant.currentLocation = await Utils.getCurrentLocation();
  }
}
