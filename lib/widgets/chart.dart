import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Text("Chart"),
        color: Theme.of(context).primaryColor,
        elevation: 12,
      ),
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
        ),
      ),
    );
  }
}
