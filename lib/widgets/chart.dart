import 'package:flutter/material.dart';

import './chart_bar.dart';
import '../models/transaction_summary.dart';

class Chart extends StatelessWidget {
  final List<TransactionSummary> weeklyTransactionSummary;

  const Chart({required this.weeklyTransactionSummary});

  double get totalSumOfWeeklyTransactions {
    final double total = weeklyTransactionSummary.fold(
        0, (sum, current) => sum + current.totalSum);
    return total;
  }

  double calculatePercentage(double sum, double totalSumOfWeeklyTransactions) {
    if (sum == 0) {
      return 0;
    }
    return (sum / totalSumOfWeeklyTransactions);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      margin: EdgeInsets.all(6),
      child: Padding(
        padding: EdgeInsets.all(6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...weeklyTransactionSummary.map((TransactionSummary summary) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  label: summary.day,
                  spendingAmount: summary.totalSum,
                  spendingPercentageOfTotal: calculatePercentage(
                      summary.totalSum, totalSumOfWeeklyTransactions),
                ),
              );
            }),
          ],
        ),
      ),
      // color: Theme.of(context).primaryColor,
    );
  }
}
