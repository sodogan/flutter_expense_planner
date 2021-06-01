import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Text("Chart"),
        color: Colors.blue,
        elevation: 12,
      ),
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Colors.amber,
        ),
      ),
    );
  }
}
