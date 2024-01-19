import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_panda_app/global/global.dart';
import 'package:driver_panda_app/model/item_model.dart';
import 'package:driver_panda_app/model/menu_model.dart';
import 'package:driver_panda_app/view/item_upload_screen/item_upload_screen.dart';
import 'package:driver_panda_app/widget/item_info_widget.dart';
import 'package:driver_panda_app/widget/progress_dialog.dart';
import 'package:flutter/material.dart';

class ItemScreen extends StatelessWidget {
  final MenuModel? model;
  const ItemScreen({super.key, this.model});

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
                tileMode: TileMode.clamp),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ItemUploadScreen(
                              model: model,
                            )));
              },
              icon: const Icon(
                Icons.library_add,
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
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: kToolbarHeight,
              child: Center(
                  child: Text(
                "${model!.menuTitle} Items",
                style: const TextStyle(
                  shadows: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2.0,
                      offset: Offset(1, 2),
                      spreadRadius: 15.0,
                    )
                  ],
                  fontSize: 20,
                  color: Colors.black,
                  fontFamily: "Lobster",
                ),
              )),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("sellers")
                      .doc(sharedPreferences!.getString("uid"))
                      .collection("menus")
                      .doc(model!.menuID)
                      .collection("items")
                      .orderBy("publishedDate", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: circularProgress(),
                      );
                    } else {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          ItemModel menuModel = ItemModel.fromJson(
                              snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>);
                          return ItemsInfoWidget(
                            model: menuModel,
                          );
                        },
                        itemCount: snapshot.data!.docs.length,
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
