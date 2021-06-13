import 'package:flutter/material.dart';

import 'package:expense_planner/expense_planner.dart' as utility;

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
          padding: EdgeInsets.all(6),
          height: 25,
          child: FittedBox(
            child: Text(
              '\$ ${utility.formatWithFixedString(
                spendingAmount,
                decimals: 0,
              )}',
            ),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
            height: 60,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10)),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPercentageOfTotal / 4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            )),
        SizedBox(
          height: 4,
        ),
        Container(
          padding: EdgeInsets.all(6),
          child: Text(
            label,
          ),
        ),
      ],
    );
  }
}
