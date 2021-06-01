import 'package:flutter/material.dart';
import '/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList({required this.transactions});

  List<Widget> mappedList() {
    var result = transactions.map((tx) {
      var dateFormat = DateFormat.yMMMMEEEEd();

      return Card(
        child: Row(
          children: [
            Container(
              child: Text(
                '\$ ${tx.amount}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 6,
                  color: Colors.purple,
                ),
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  dateFormat.format(tx.date),
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }).toList();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ...mappedList(),
    ]);
  }
}
