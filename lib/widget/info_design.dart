import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_panda_app/global/global.dart';
import 'package:driver_panda_app/model/menu_model.dart';
import 'package:driver_panda_app/view/item_screen/item_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InfoDesign extends StatelessWidget {
  final MenuModel? model;
  final BuildContext? context;
  const InfoDesign({Key? key, this.model, this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ItemScreen(
                      model: model,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: CachedNetworkImage(
                progressIndicatorBuilder: (context, value, download) {
                  return Center(
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: Colors.amber,
                      value: download.progress,
                    ),
                  );
                },
                imageUrl: model!.thumbnailUrl!,
                height: 220.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  model!.menuTitle!,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.cyan,
                        fontFamily: "TrainOne",
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
                IconButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection("sellers")
                          .doc(sharedPreferences!.getString("uid"))
                          .collection("menus")
                          .doc(model!.menuID)
                          .delete()
                          .then((value) {
                        Fluttertoast.showToast(
                          msg: "Menu Delete Successfully",
                        );
                      });
                    },
                    icon: const Icon(Icons.delete_sweep, color: Colors.red))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
