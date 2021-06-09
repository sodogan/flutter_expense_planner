import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransactionHandler;

  static const String _labelTitle = "Title";
  static const String _labelAmount = "Amount";
  static const String _labelDate = "Date";

  /// Label for Add new transaction
  static const String _buttonLabelAddTxn = "Add Transaction";
  static const String _buttonLabelChooseDate = "Choose Date";

  NewTransaction({required this.addNewTransactionHandler});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = new TextEditingController();
  final amountController = new TextEditingController();

  void _submitData() {
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
      amount: parsedAmount,
      dateTime: DateTime.now(),
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
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              style: Theme.of(context).textTheme.headline6,
              decoration: InputDecoration(
                labelText: NewTransaction._labelTitle,
              ),
              controller: titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              style: Theme.of(context).textTheme.headline6,
              decoration: InputDecoration(
                labelText: NewTransaction._labelAmount,
              ),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              style: Theme.of(context).textTheme.headline6,
              decoration: InputDecoration(
                labelText: NewTransaction._labelDate,
              ),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            TextButton(
              onPressed: null,
              child: Text(
                NewTransaction._buttonLabelChooseDate,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(8),
              child: TextButton(
                onPressed: _submitData,
                child: Text(
                  NewTransaction._buttonLabelAddTxn,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
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
