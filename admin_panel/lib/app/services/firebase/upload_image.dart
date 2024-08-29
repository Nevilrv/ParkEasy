import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

Future<String> uploadPic(PickedFile image, String fileName, String mimeType) async {
  //Create a reference to the location you want to upload to in firebase
  UploadTask uploadTask;
  Reference ref = FirebaseStorage.instance.ref().child('facilities').child(fileName);

  //Upload the file to firebase
  uploadTask = ref.putData(
      await image.readAsBytes(),
      SettableMetadata(
        contentType: mimeType,
        customMetadata: {'picked-file-path': image.path},
      ));

  String url = await uploadTask.then((taskSnapshot) async {
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  });

  return url;
}
