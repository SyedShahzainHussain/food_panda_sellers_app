import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_panda_app/firebase/firebase_storage/firebase_storage.dart';
import 'package:driver_panda_app/global/global.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadItemViewModel with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> uploadItem(XFile? image, String? titleInfo, String? shortInfo,
      context, String menuId, String description, String price) async {
    setLoading(true);
    String unique = DateTime.now().toIso8601String();
    try {
      // ! upload iamge to storage

      await FirebaseStorageFile.uploadFileToStorage("items", image!)
          .then((value) {
        // ! upload data to firestore
        final ref = FirebaseFirestore.instance
            .collection("sellers")
            .doc(sharedPreferences!.getString("uid"))
            .collection("menus")
            .doc(menuId)
            .collection("items");
  
        ref.doc(unique).set({
          "itemID": unique,
          "menuID": menuId,
          "sellerID": sharedPreferences!.getString("uid"),
          "sellerName": sharedPreferences!.getString("name"),
          "itemInfo": shortInfo,
          "itemTitle": titleInfo,
          "itemDescription": description,
          "price": int.parse(price),
          "publishedDate": DateTime.now(),
          "status": "available",
          "thumbnailUrl": value,
        }).then((value2) {
          final ref = FirebaseFirestore.instance.collection("items");
          ref.doc(unique).set({
            "itemID": unique,
            "menuID": menuId,
            "sellerID": sharedPreferences!.getString("uid"),
            "sellerName": sharedPreferences!.getString("name"),
            "itemInfo": shortInfo,
            "itemTitle": titleInfo,
            "itemDescription": description,
            "price": int.parse(price),
            "publishedDate": DateTime.now(),
            "status": "available",
            "thumbnailUrl": value,
          }).then((_) {
            setLoading(false);
          });
        });
      });
    } catch (e) {
      setLoading(false);
    }
  }
}
