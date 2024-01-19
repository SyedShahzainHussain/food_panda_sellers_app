import 'dart:io';

import 'package:driver_panda_app/viewModel/upload_menu/upload_menu.dart';
import 'package:driver_panda_app/widget/alert_dialog.dart';
import 'package:driver_panda_app/widget/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MenuUploadScreen extends StatefulWidget {
  const MenuUploadScreen({super.key});

  @override
  State<MenuUploadScreen> createState() => _MenuUploadScreenState();
}

class _MenuUploadScreenState extends State<MenuUploadScreen> {
  XFile? image;
  final picker = ImagePicker();
  final titleController = TextEditingController();
  final infoController = TextEditingController();

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
            "Add New Menu",
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
                  "Add New Menu",
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
              title: const Text("Menu Image",
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
  menuUploadScreen() {
    return Scaffold(
        appBar: AppBar(
            actions: [
              TextButton(
                  onPressed: () {
                    addMenu();
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
              "Uploading New Menu",
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
            Consumer<UploadViewModel>(builder: (context, value, child) {
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
                  hintText: "Menu Title",
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
                  hintText: "Menu Info",
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
  addMenu() {
    if (image != null) {
      if (titleController.text.isNotEmpty && infoController.text.isNotEmpty) {
        context
            .read<UploadViewModel>()
            .uploadMenu(
              image,
              titleController.text,
              infoController.text,
              context,
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
    return image == null ? defaultScreen() : menuUploadScreen();
  }
}
