import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_panda_app/global/global.dart';
import 'package:driver_panda_app/view/menu_upload_screen/menu_upload_screen.dart';
import 'package:driver_panda_app/view/menus_screen/menus_screen.dart';
import 'package:driver_panda_app/view/my_splash_screen/my_splash_screen.dart';
import 'package:driver_panda_app/widget/my_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  initState() {
    super.initState();

    checkUserIsBlock();
  }

  checkUserIsBlock() async {
    FirebaseFirestore.instance
        .collection("sellers")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.data()!["status"] != "approved") {
        Fluttertoast.showToast(msg: "you have been blocked");
        FirebaseAuth.instance.signOut();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const SplashScreen()),
            (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
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
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MenuUploadScreen()));
              },
              icon: const Icon(
                Icons.post_add,
                color: Colors.cyan,
              ))
        ],
        title: Text(
          sharedPreferences?.getString("name") ?? "",
          style: const TextStyle(
              fontSize: 20, color: Colors.white, fontFamily: "Lobster"),
        ),
        centerTitle: true,
      ),
      body: const MenusScreen(),
    );
  }
}
