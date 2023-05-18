import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }
}

extension AsyncValueUI on AsyncValue<void> {
  void showBannerOnError(BuildContext context) => whenOrNull(
        error: (error, _) {
          ScaffoldMessenger.of(context)
            ..hideCurrentMaterialBanner()
            ..showMaterialBanner(
              MaterialBanner(
                content: const Text(
                  'Please enter correct credentials',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                    },
                    child: const Text('Dismiss'),
                  ),
                ],
              ),
            );
        },
      );
}
