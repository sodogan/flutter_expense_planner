import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expense_planner/expense_planner.dart' as utility;

import 'adaptive_text_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransactionHandler;

  NewTransaction({
    Key? key,
    required this.addNewTransactionHandler,
  }) : super(key: key) {
    print('Constructor in NewTransaction widget');
  }

  @override
  _NewTransactionState createState() {
    print('CreateState in NewTransaction widget');

    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController _titleController;
  final TextEditingController _amountController;
  DateTime? _selectedDate;

  _NewTransactionState()
      : _titleController = TextEditingController(),
        _amountController = TextEditingController() {
    print('Constructor in NewTransaction state');
  }
  @override
  void initState() {
    super.initState();
    print('InitState is called');
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('DidupdateWidget is called');
  }

  @override
  void dispose() {
    super.dispose();
    print('Dispose is called');
  }

  void _submitData() {
    final String _title = _titleController.text;
    final String _amount = _amountController.text;
    final double? _parsedAmount = double.tryParse(_amount);

    if (_amount.isEmpty ||
        _title.isEmpty ||
        _selectedDate == null ||
        _parsedAmount == null ||
        _parsedAmount <= 0) {
      //can also give an error message
      return;
    }

    widget.addNewTransactionHandler(
      title: _titleController.text,
      amount: _parsedAmount,
      dateTime: _selectedDate,
    );
    //close the modal as soon as new txn is added
    Navigator.of(context).pop();
  }

  void _presentDatePicker() async {
    final DateTime? _pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(
        2019,
      ),
      lastDate: DateTime.now(),
    );

//if user tap cancel then this function will stop
    if (_pickedDate == null) {
      return;
    }

    setState(() {
      _selectedDate = _pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    const _labelTitle = 'Title';
    const _labelAmount = 'Amount';
    const _labelDate = 'No Date chosen';
    const _buttonLabelAddTxn = 'Add Transaction';
    const _buttonLabelChooseDate = 'Choose Date';

    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            left: 10,
            right: 10,
            top: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                style: Theme.of(context).textTheme.headline6,
                decoration: const InputDecoration(
                  labelText: _labelTitle,
                ),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                style: Theme.of(context).textTheme.headline6,
                decoration: const InputDecoration(
                  labelText: _labelAmount,
                ),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FittedBox(
                      child: Text(
                        _selectedDate == null
                            ? _labelDate
                            : utility.formatDateWithWeekDay(_selectedDate!),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Expanded(
                        child: AdaptiveTextButton(
                      datePickerHandler: _presentDatePicker,
                      label: _buttonLabelChooseDate,
                    )),
                  ],
                ),
              ),
              const Divider(
                //color: Colors.red,
                height: 6,
                thickness: 2,
              ),
              const SizedBox(height: 8),
              Container(
                margin: const EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: _submitData,
                  child: Text(
                    _buttonLabelAddTxn,
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
      ),
    );
  }
}
