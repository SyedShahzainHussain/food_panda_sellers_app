import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_panda_app/widget/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../global/global.dart';
import '../../viewModel/order_viewModel/order_view_model.dart';
import '../../widget/my_drawer.dart';
import '../../widget/order_card_widget.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

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
        title: const Text(
          "History",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontFamily: "Signatra",
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("orders")
              .where("sellerUID",
                  isEqualTo: sharedPreferences!.getString("uid"))
              .where("status", isEqualTo: "ended")
              .orderBy("orderTime", descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      return FutureBuilder<QuerySnapshot>(
                          future: FirebaseFirestore.instance
                              .collection("items")
                              .where("itemID",
                                  whereIn: Provider.of<OrderViewModel>(context)
                                      .separateOrderItemsIds(snapshot
                                          .data!.docs[index]
                                          .data()["productsIDs"]))
                              .orderBy("publishedDate", descending: true)
                              .get(),
                          builder: (context, snapshot2) {
                            return snapshot2.hasData
                                ? OrderWidget(
                                    itemCount: snapshot2.data!.docs.length,
                                    orderId: snapshot.data!.docs[index]
                                        ["orderId"],
                                    data: snapshot2.data!.docs,
                                    separateQuantitiesList:
                                        Provider.of<OrderViewModel>(context)
                                            .separateOrderQuantity(snapshot
                                                .data!.docs[index]
                                                .data()["productsIDs"]),
                                  )
                                : const SizedBox.shrink();
                          });
                    },
                    itemCount: snapshot.data!.docs.length,
                  )
                : Center(
                    child: circularProgress(),
                  );
          }),
    );
  }
}
