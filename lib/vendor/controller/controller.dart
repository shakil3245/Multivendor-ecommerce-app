import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class VendorController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;

//FUNCTION TO UPLOAD IMAGE TO FIREBASE STORAGE
  _uploadVendorImageToStorage(Uint8List? image) async {
    Reference ref =
        _storage.ref().child('storeImage').child(_auth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(image!);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  //FUNCTION TO PICK STORE IMAGE
  PicStoreImage(ImageSource image) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? _file = await imagePicker.pickImage(source: image);
    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      print("Image not selected!");
    }
  }

  // FUNCTION TO SAVE VENDOR DATA
  Future<String> registertion(String bussinessName, String email,
      String phoneNumber, String location, Uint8List? image) async {
    String res = "something went wrong!";
    try {
      if (bussinessName.isNotEmpty &&
          email.isNotEmpty &&
          location.isNotEmpty &&
          image!.isNotEmpty && phoneNumber.isNotEmpty) {
        //SAVE DATA TO CLOUDE FIRE STORE
        String storeImage =await _uploadVendorImageToStorage(image);
        await _fireStore.collection('vendors').doc(_auth.currentUser!.uid).set({
          "bussinessName": bussinessName,
          "email": email,
          "phone": phoneNumber,
          "location": location,
          "storeImage": storeImage,
          "createdAt": DateTime.now(),
          "Uid": _auth.currentUser!.uid,
          "approved": false,

        });
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
