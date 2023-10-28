import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';


void successSnackBar(String head, String body, BuildContext context) {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.success,
    title: head,
    text: body,
  );
}

void failSnackBar(String head, String body, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(head),
  ));
}

showLoadingDialog(BuildContext context, {bool dismissible = true}) {
  showDialog(
    barrierDismissible: dismissible,
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: Colors.black38,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          SizedBox(height: 50, width: 50, child: CircularProgressIndicator()),
        ],
      ),
    ),
  );
}

dismissLoadingDialog(var context) {
  Navigator.pop(context);
}
