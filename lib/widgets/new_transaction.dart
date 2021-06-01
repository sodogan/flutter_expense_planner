import 'package:flutter/material.dart';
import '../models/transaction.dart';

class NewTransaction extends StatelessWidget {
  final Function onPressHandler;

  final titleController = new TextEditingController();
  final amountController = new TextEditingController();

  NewTransaction({required this.onPressHandler});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              controller: titleController,
            ),
            TextField(
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              controller: amountController,
            ),
            Container(
              padding: EdgeInsets.all(4),
              margin: EdgeInsets.all(8),
              child: TextButton(
                onPressed: () => onPressHandler(
                  new Transaction(
                    id: "12",
                    title: titleController.text,
                    amount: double.parse(amountController.text),
                    date: DateTime.now(),
                  ),
                ),
                child: Text(
                  "Add Transaction",
                  style: TextStyle(
                    color: Colors.purple,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
