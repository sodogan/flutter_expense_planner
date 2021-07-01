import 'package:expense_planner/expense_planner.dart' as utility;

class TransactionSummary implements Comparable<TransactionSummary> {
  final DateTime dateTime;
  final double dailySum;
  final String day;

  const TransactionSummary({
    required this.dateTime,
    required this.dailySum,
    required this.day,
  });

  TransactionSummary.withDayKey(
      {required DateTime dateTime, required double dailySum})
      : this(
          dateTime: dateTime,
          dailySum: dailySum,
          day: utility.getDayKey(dateTime),
        );

  factory TransactionSummary.fromJSON(Map<String, Object> json) =>
      TransactionSummary.withDayKey(
        dateTime: json['dateTime'] as DateTime,
        dailySum: json['dailySum'] as double,
      );

  @override
  int compareTo(TransactionSummary other) {
    return dateTime.compareTo(other.dateTime);
  }

  @override
  String toString() {
    return 'dateTime: $dateTime\n'
        'day     :  $day\n'
        'daily amount  :  $dailySum\n';
  }
}
