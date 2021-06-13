import 'package:flutter/material.dart';

import 'package:expense_planner/expense_planner.dart' as utility;

class NewTransaction extends StatefulWidget {
  final Function addNewTransactionHandler;

  static const String _labelTitle = "Title";
  static const String _labelAmount = "Amount";
  static const String _labelDate = "No Date chosen";

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
  DateTime? _selectedDate;

  void _submitData() {
    final String _title = titleController.text;
    final String _amount = amountController.text;
    final double? parsedAmount = double.tryParse(_amount);

    if (_amount.isEmpty ||
        _title.isEmpty ||
        _selectedDate == null ||
        parsedAmount == null ||
        parsedAmount <= 0) {
      //can also give an error message
      return;
    }

    widget.addNewTransactionHandler(
      title: titleController.text,
      amount: parsedAmount,
      dateTime: _selectedDate,
    );
    //close the modal as soon as new txn is added
    Navigator.of(context).pop();
  }

  void _presentDatePicker() async {
    final DateTime? _chosenDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(
        2019,
      ),
      lastDate: DateTime.now(),
    );

    setState(() {
      _selectedDate = _chosenDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(8),
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
            Container(
              padding: EdgeInsets.only(top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FittedBox(
                    child: Text(
                      _selectedDate == null
                          ? NewTransaction._labelDate
                          : utility.formatDateWithWeekDay(_selectedDate!),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: _presentDatePicker,
                      child: Text(
                        NewTransaction._buttonLabelChooseDate,
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
            Divider(
              //color: Colors.red,
              height: 6,
              thickness: 2,
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: _submitData,
                child: Text(
                  NewTransaction._buttonLabelAddTxn,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.button?.color,
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
