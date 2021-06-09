import 'package:flutter/material.dart';

import './chart_bar.dart';
import '../models/transaction_summary.dart';

class Chart extends StatelessWidget {
  final List<TransactionSummary> weeklyTransactionSummary;

  const Chart({required this.weeklyTransactionSummary});

  double get totalSumOfAllTransactions {
    final double total = weeklyTransactionSummary.fold(
        0, (sum, current) => sum + current.totalSum);
    return total;
  }

  double calculatePercentage(double sum, double totalSumOfAllTransactions) {
    if (sum == 0) {
      return 0;
    }
    return (sum / totalSumOfAllTransactions) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(12),
        child: Row(
          children: [
            ...weeklyTransactionSummary.map((TransactionSummary summary) {
              return ChartBar(
                label: summary.day,
                spendingAmount: summary.totalSum,
                spendingPercentageOfTotal: calculatePercentage(
                    summary.totalSum, totalSumOfAllTransactions),
              );
            }),
          ],
        ),
        color: Theme.of(context).primaryColor,
      ),
      height: 150,
      width: double.infinity,
    );
  }
}
