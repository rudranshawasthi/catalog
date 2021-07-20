import 'dart:async';

import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FlashHelper {
  static Future<T> informationBar<T>(
    BuildContext context, {
    String title,
    @required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    return showFlash<T>(
      context: context,
      duration: duration,
      builder: (_, controller) {
        return Flash(
          controller: controller,
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          backgroundColor: Colors.black87,
          child: FlashBar(
            title: title == null
                ? null
                : Text(title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    )),
            message: Text(message,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                )),
            icon: Icon(Icons.info_outline, color: Colors.blue[300]),
            leftBarIndicatorColor: Colors.blue[300],
          ),
        );
      },
    );
  }
}
