//import "package:flutter/foundation.dart";

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  const Transaction(
      {required this.id,
      required this.title,
      required this.amount,
      required this.date});
  Transaction.now({
    required this.id,
    required this.title,
    required this.amount,
  }) : this.date = DateTime.now();

  factory Transaction.fromJSON(Map<String, dynamic> json) {
    return Transaction(
      id: json["id"],
      title: json["title"],
      amount: json["amount"],
      date: json["date"],
    );
  }
}