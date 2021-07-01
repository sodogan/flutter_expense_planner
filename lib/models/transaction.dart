import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

@immutable
class Transaction implements Comparable<Transaction> {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  const Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });

  Transaction.now({
    required this.id,
    required this.title,
    required this.amount,
  }) : date = DateTime.now();

  factory Transaction.fromJSON(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      title: json['title'],
      amount: json['amount'],
      date: json['date'],
    );
  }

  @override
  String toString() {
    return 'id: $id '
        'title: $title'
        'amount: $amount'
        'date: $date';
  }

  @override
  int compareTo(Transaction other) {
    return date.compareTo(other.date);
  }
}
