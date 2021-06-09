import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentageOfTotal;

  const ChartBar({
    Key? key,
    required this.label,
    required this.spendingAmount,
    required this.spendingPercentageOfTotal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          child: Text(
            '\$ ${spendingAmount.toStringAsFixed(2)}',
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 30,
          width: 10,
          child: Text(
            '% ${spendingPercentageOfTotal.toStringAsFixed(0)}',
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          padding: EdgeInsets.all(12),
          child: Text(
            label,
          ),
        ),
      ],
    );
  }
}
