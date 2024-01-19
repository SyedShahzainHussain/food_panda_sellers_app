import 'package:driver_panda_app/widget/progress_dialog.dart';
import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  final String? message;
  const LoadingDialog({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          circularProgress(),
          const SizedBox(
            height: 10,
          ),
          Text(
            "$message Please wait...",
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(fontFamily: "Signatra"),
          ),
        ],
      ),
    );
  }
}
