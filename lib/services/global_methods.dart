import 'package:flutter/material.dart';

import '../styles/clr.dart';
import '../styles/layout.dart';
import "../styles/txt.dart";

class GlobalMethod {
  static void showErrorDialog({
    required BuildContext context,
		required IconData icon,
		required Color iconColor,
    required String title,
		required String body,
		required String buttonText,
  }) {
		showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: layout.elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(layout.radius),
          ),
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(layout.padding / 2),
                child: Icon(
                  icon,
                  size: layout.dialogIconSize,
                  color: iconColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(layout.padding),
                child: Text(
                  title,
                  style: txt.dialogTitle,
                ),
              ),
            ],
          ),
          content: Text(
            body,
            style: txt.dialogBody,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.canPop(context) ? Navigator.pop(context) : null;
              },
              child: Text(
                buttonText,
                style: txt.dialogOptions,
              ),
            ),
          ],
        );
      },
    );
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Row(
  //           children: const [
  //             Padding(
  //               padding: EdgeInsets.all(layout.padding),
  //               child: Icon(
  //                 Icons.warning_amber_outlined,
  //                 color: Colors.grey,
  //                 size: 55,
  //               ),
  //             ),
  //             Padding(
  //               padding: EdgeInsets.all(8.0),
  //               child: Text('Error occured'),
  //             ),
  //           ],
  //         ),
  //         content: Text(
  //           error,
  //           style: const TextStyle(
  //             color: Colors.black,
  //             fontSize: 20,
  //             fontStyle: FontStyle.italic,
  //           ),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.canPop(context) ? Navigator.pop(context) : null;
  //             },
  //             child: const Text(
  //               'OK',
  //               style: TextStyle(color: Colors.red),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  }
}
