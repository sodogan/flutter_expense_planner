import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransactionHandler;

  static const String _labelTitle = "Title";
  static const String _labelAmount = "Amount";
  static const String _buttonLabel = "Add Transaction";

  NewTransaction({required this.addNewTransactionHandler});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = new TextEditingController();

  final amountController = new TextEditingController();

  void submitData() {
    final String title = titleController.text;
    final String amount = amountController.text;
    final double? parsedAmount = double.tryParse(amount);

    if (amount.isEmpty ||
        title.isEmpty ||
        parsedAmount == null ||
        parsedAmount <= 0) {
      //can also give an error message
      return;
    }

    widget.addNewTransactionHandler(
      title: titleController.text,
      amount: double.parse(parsedAmount.toStringAsFixed(2)),
    );
    //close the modal as soon as new txn is added
    Navigator.of(context).pop();
  }

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
                labelText: NewTransaction._labelTitle,
              ),
              controller: titleController,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                labelText: NewTransaction._labelAmount,
              ),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            Container(
              padding: EdgeInsets.all(4),
              margin: EdgeInsets.all(8),
              child: TextButton(
                onPressed: submitData,
                child: Text(
                  NewTransaction._buttonLabel,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
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
