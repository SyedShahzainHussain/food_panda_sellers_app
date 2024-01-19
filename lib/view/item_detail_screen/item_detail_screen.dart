import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_panda_app/global/global.dart';
import 'package:driver_panda_app/view/my_splash_screen/my_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../model/item_model.dart';

class ItemDetailScreen extends StatefulWidget {
  final ItemModel? itemModel;
  const ItemDetailScreen({super.key, this.itemModel});

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  final counterCountroller = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    counterCountroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                tileMode: TileMode.clamp,
              ),
            ),
          ),
          title: Text(
            widget.itemModel!.itemTitle!,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontFamily: "Signatra",
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height -
                  MediaQuery.paddingOf(context).top -
                  kToolbarHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.itemModel!.thumbnailUrl!,
                    height: MediaQuery.sizeOf(context).height / 4,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.itemModel!.itemTitle!,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.itemModel!.itemDescription!,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontWeight: FontWeight.normal)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${widget.itemModel!.price} Rs",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 10),
                  const Spacer(),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        FirebaseFirestore.instance
                            .collection("sellers")
                            .doc(sharedPreferences!.getString("uid"))
                            .collection("menus")
                            .doc(widget.itemModel!.menuID)
                            .collection("items")
                            .doc(widget.itemModel!.itemID)
                            .delete()
                            .then((value) {
                          FirebaseFirestore.instance
                              .collection("items")
                              .doc(widget.itemModel!.itemID)
                              .delete()
                              .then((value) async {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SplashScreen()),
                                (route) => false);
                            await Fluttertoast.showToast(
                                msg: "Items has been deleted successfully");
                          });
                        });
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.cyan, Colors.amber],
                              begin: FractionalOffset(0.0, 0.0),
                              end: FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        width: MediaQuery.sizeOf(context).width - 15,
                        height: 50,
                        child: Center(
                            child: Text(
                          "Delete This Item",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ));
  }
}
