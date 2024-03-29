import 'package:flutter/material.dart';

import '../view/home_screen/home_screen.dart';

class StatusBanner extends StatelessWidget {
  final bool? status;
  final String? orderStatus;

  const StatusBanner({super.key, this.status, this.orderStatus});

  @override
  Widget build(BuildContext context) {
    String? message;
    IconData? icon;

    status! ? message = "SuccessFull" : message = "Unsuccessful";
    status! ? icon = Icons.done : icon = Icons.cancel;
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.cyan, Colors.amber],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen())),
              child: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              orderStatus == "ended"
                  ? "Parcel Delivered $message"
                  : "Order Placed $message",
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(
              width: 5,
            ),
            CircleAvatar(
              radius: 8,
              backgroundColor: Colors.grey,
              child: Center(
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 14,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
