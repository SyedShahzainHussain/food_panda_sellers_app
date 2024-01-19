import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_panda_app/firebase/firebase_storage/firebase_storage.dart';
import 'package:driver_panda_app/global/global.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadViewModel with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> uploadMenu(
      XFile? image, String? titleInfo, String? shortInfo, context) async {
    setLoading(true);
    String unique = DateTime.now().toIso8601String();
    try {
      // ! upload iamge to storage

      await FirebaseStorageFile.uploadFileToStorage("menus", image!)
          .then((value) {
        // ! upload data to firestore
        final ref = FirebaseFirestore.instance
            .collection("sellers")
            .doc(sharedPreferences!.getString("uid"))
            .collection("menus");

        ref.doc(unique).set({
          "menuID": unique,
          "sellerID": sharedPreferences!.getString("uid"),
          "menuInfo": shortInfo,
          "menuTitle": titleInfo,
          "publishedDate": DateTime.now(),
          "status": "available",
          "thumbnailUrl": value,
        }).then((value) {
          setLoading(false);
        });
      });
    } catch (e) {
      setLoading(false);
    }
  }
}
