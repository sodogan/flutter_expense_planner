import 'package:expense_planner/expense_planner.dart' as utility;

class TransactionSummary {
  final DateTime dateTime;
  final double totalSum;
  final String day;

  TransactionSummary({required this.dateTime, required this.totalSum})
      : this.day = utility.getDayKey(dateTime);

  factory TransactionSummary.fromJSON(Map<String, Object> json) =>
      TransactionSummary(
        dateTime: json['dateTime'] as DateTime,
        totalSum: json['totalSum'] as double,
      );

  @override
  String toString() {
    return "dateTime: $dateTime\n"
        "day     :  $day\n"
        "amount  :  $totalSum\n";
  }
}
