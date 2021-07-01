import 'package:flutter/material.dart';

import './chart_bar.dart';
import '../models/transaction_summary.dart';

class Chart extends StatelessWidget {
  final List<TransactionSummary> weeklyTransactionSummary;

  const Chart({Key? key, required this.weeklyTransactionSummary})
      : super(
          key: key,
        );

  double get totalSumOfWeeklyTransactions {
    final double total = weeklyTransactionSummary.fold(
      0,
      (sum, current) => sum + current.dailySum,
    );
    return total;
  }

  double calculatePercentage(double sum, double totalSumOfWeeklyTransactions) {
    return totalSumOfWeeklyTransactions > 0
        ? (sum / totalSumOfWeeklyTransactions)
        : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      margin: const EdgeInsets.all(6),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...weeklyTransactionSummary.map((TransactionSummary summary) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  label: summary.day,
                  spendingAmount: summary.dailySum,
                  spendingPercentageOfTotal: calculatePercentage(
                    summary.dailySum,
                    totalSumOfWeeklyTransactions,
                  ),
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
