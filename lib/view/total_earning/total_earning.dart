import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_panda_app/global/global.dart';
import 'package:flutter/material.dart';

import '../my_splash_screen/my_splash_screen.dart';

class TotalEarnings extends StatefulWidget {
  const TotalEarnings({super.key});

  @override
  State<TotalEarnings> createState() => _TotalEarningsState();
}

class _TotalEarningsState extends State<TotalEarnings> {
  double sellerTotalEarning = 0.0;

  void getSellereTotalEarning() async {
    FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .get()
        .then((value) {
      setState(() {
        sellerTotalEarning = double.parse(value.data()!["earnings"]);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getSellereTotalEarning();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const SplashScreen()),
              (route) => false);
          return true;
        },
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Rs $sellerTotalEarning",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white, fontFamily: "Signatra")),
            Text("Total Earnings",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                      fontFamily: "Signatra",
                      letterSpacing: 3,
                    )),
            const SizedBox(
              width: 200,
              height: 20,
              child: Divider(
                color: Colors.white,
                thickness: 1.3,
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SplashScreen()),
                    (route) => false);
              },
              child: const Card(
                color: Colors.white54,
                margin: EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 140,
                ),
                child: ListTile(
                    leading: Icon(Icons.arrow_back, color: Colors.white),
                    title: FittedBox(
                      child: Text("Go Back",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          )),
                    )),
              ),
            )
          ],
        )),
      ),
    );
  }
}
