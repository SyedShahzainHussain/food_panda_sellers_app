import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_panda_app/global/global.dart';
import 'package:driver_panda_app/model/menu_model.dart';
import 'package:driver_panda_app/widget/info_design.dart';
import 'package:driver_panda_app/widget/progress_dialog.dart';
import 'package:flutter/material.dart';

class MenusScreen extends StatelessWidget {
  const MenusScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(children: [
        const SizedBox(
          width: double.infinity,
          height: kToolbarHeight,
          child: Center(
              child: Text(
            "My Menus",
            style: TextStyle(
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
                  .collection("menus").orderBy("publishedDate",descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: circularProgress(),
                  );
                } else {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      MenuModel menuModel = MenuModel.fromJSon(
                          snapshot.data!.docs[index].data()
                              as Map<String, dynamic>);
                      return InfoDesign(
                        model: menuModel,
                      );
                    },
                    itemCount: snapshot.data!.docs.length,
                  );
                }
              }),
        )
      ]),
    );
  }
}
