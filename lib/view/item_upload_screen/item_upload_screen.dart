import 'dart:io';

import 'package:driver_panda_app/model/menu_model.dart';
import 'package:driver_panda_app/viewModel/upload_item/upload_item_view_model.dart';
import 'package:driver_panda_app/widget/alert_dialog.dart';
import 'package:driver_panda_app/widget/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ItemUploadScreen extends StatefulWidget {
  final MenuModel? model;
  const ItemUploadScreen({super.key, this.model});

  @override
  State<ItemUploadScreen> createState() => _ItemUploadScreenState();
}

class _ItemUploadScreenState extends State<ItemUploadScreen> {
  XFile? image;
  final picker = ImagePicker();
  final titleController = TextEditingController();
  final infoController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();

  // ! defaultScreen
  defaultScreen() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          centerTitle: true,
          title: const Text(
            "Add New Item",
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontFamily: "Lobster"),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.cyan, Colors.amber],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          )),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.cyan, Colors.amber],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.shop_two,
                color: Colors.white,
                size: 200.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: Colors.amber,
                ),
                onPressed: () {
                  takeImage(context);
                },
                child: const Text(
                  "Add New Item",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ! take Image
  takeImage(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
              backgroundColor: Colors.black,
              title: const Text("Item Image",
                  style: TextStyle(
                      color: Colors.amber, fontWeight: FontWeight.bold)),
              children: [
                SimpleDialogOption(
                    onPressed: capturedImageFromCamera,
                    child: const Text("Capture with Camera",
                        style: TextStyle(
                          color: Colors.grey,
                        ))),
                SimpleDialogOption(
                    onPressed: capturedImageFromGallery,
                    child: const Text("Selected from Gallery",
                        style: TextStyle(
                          color: Colors.grey,
                        ))),
                SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel",
                        style: TextStyle(
                          color: Colors.red,
                        ))),
              ]);
        });
  }

  // ! captureImageCamera
  capturedImageFromCamera() async {
    Navigator.pop(context);
    image = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 720,
      maxWidth: 1280,
    );
    setState(() {
      image;
    });
  }

  // ! captureImageGallery
  capturedImageFromGallery() async {
    Navigator.pop(context);
    image = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 720,
      maxWidth: 1280,
    );
    setState(() {
      image;
    });
  }

  // ! menuUploadImage
  itemUploadScreen() {
    return Scaffold(
        appBar: AppBar(
            actions: [
              TextButton(
                  onPressed: () {
                    addItem();
                  },
                  child: const Text(
                    "Add",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: "Varela",
                    ),
                  ))
            ],
            centerTitle: true,
            title: const Text(
              "Uploading New Item",
              style: TextStyle(
                  fontSize: 20, color: Colors.white, fontFamily: "Lobster"),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            elevation: 0,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.cyan, Colors.amber],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
            )),
        body: ListView(
          children: [
            Consumer<UploadItemViewModel>(builder: (context, value, child) {
              return value.isLoading
                  ? linearProgress()
                  : const SizedBox.shrink();
            }),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: FileImage(
                        File(
                          image!.path,
                        ),
                      ),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            const Divider(
              thickness: 2,
              color: Colors.amber,
            ),
            ListTile(
              leading: const Icon(
                Icons.title,
                color: Colors.cyan,
              ),
              title: TextField(
                style: const TextStyle(color: Colors.black),
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
            const Divider(
              thickness: 2,
              color: Colors.amber,
            ),
            ListTile(
              leading: const Icon(
                Icons.perm_device_information,
                color: Colors.cyan,
              ),
              title: TextField(
                style: const TextStyle(color: Colors.black),
                controller: infoController,
                decoration: const InputDecoration(
                  hintText: "Info",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
            const Divider(
              thickness: 2,
              color: Colors.amber,
            ),
            ListTile(
              leading: const Icon(
                Icons.description,
                color: Colors.cyan,
              ),
              title: TextField(
                style: const TextStyle(color: Colors.black),
                controller: descriptionController,
                decoration: const InputDecoration(
                  hintText: "description",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
            const Divider(
              thickness: 2,
              color: Colors.amber,
            ),
            ListTile(
              leading: const Icon(
                Icons.camera,
                color: Colors.cyan,
              ),
              title: TextField(
                style: const TextStyle(color: Colors.black),
                controller: priceController,
                decoration: const InputDecoration(
                  hintText: "Price",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
            const Divider(
              thickness: 2,
              color: Colors.amber,
            ),
          ],
        ));
  }

  // ! clear Menu Form
  clearMenuForm() {
    setState(() {
      titleController.clear();
      infoController.clear();
      image = null;
    });
  }

  // ! add Menu
  addItem() {
    if (image != null) {
      if (titleController.text.isNotEmpty &&
          infoController.text.isNotEmpty &&
          descriptionController.text.isNotEmpty &&
          priceController.text.isNotEmpty) {
        context
            .read<UploadItemViewModel>()
            .uploadItem(
              image,
              titleController.text,
              infoController.text,
              context,
              widget.model!.menuID!,
              descriptionController.text,
              priceController.text,
            )
            .then((value) {
          clearMenuForm();
        });
      } else {
        showDialog(
            context: context,
            builder: (context) => const ErrorDialog(
                  message: "Please write title and info for Menus.",
                ));
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const ErrorDialog(
          message: "Please pick an Image for Menu.",
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return image == null ? defaultScreen() : itemUploadScreen();
  }
}
