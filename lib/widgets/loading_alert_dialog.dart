import 'package:flutter/material.dart';

void showLoadingAlertDialog(BuildContext context, {String? text}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 15),
              Text(text ?? 'Yükleniyor...')
            ],
          ),
        ),
      );
    },
  );
}
