import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

class AdaptiveTextButton extends StatelessWidget {
  final VoidCallback datePickerHandler;
  final String label;

  const AdaptiveTextButton({
    Key? key,
    required this.datePickerHandler,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: datePickerHandler,
            child: Text(
              label,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : TextButton(
            onPressed: datePickerHandler,
            child: Text(
              label,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}
