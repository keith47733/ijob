import 'package:flutter/material.dart';

import 'layout.dart';

class GlobalMethod {
  static void showErrorDialog({required BuildContext context, required String error}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: const [
              Padding(
                padding: EdgeInsets.all(Layout.appPadding),
                child: Icon(
                  Icons.warning_amber_outlined,
                  color: Colors.grey,
                  size: 55,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Error occured'),
              ),
            ],
          ),
          content: Text(
            error,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontStyle: FontStyle.italic,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
								Navigator.canPop(context) ? Navigator.pop(context) : null;
							},
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
