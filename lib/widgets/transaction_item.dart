import 'dart:math';

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:expense_planner/expense_planner.dart' as utility;

class TransactionItem extends StatefulWidget {
  final Transaction transaction;
  final VoidCallback deleteButtonPressedHandler;

  const TransactionItem(
      {Key? key,
      required this.transaction,
      required this.deleteButtonPressedHandler})
      : super(key: key);

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  static const availableColors = <Color>[
    Colors.purple,
    Colors.blue,
    Colors.green
  ];

  late Color _randomBackgroundColor;

  @override
  void initState() {
    super.initState();
    _randomBackgroundColor = availableColors[Random().nextInt(3)];
    print(
        'initstate in transaction item ${_randomBackgroundColor.value.toString()}');
  }

  @override
  void dispose() {
    super.dispose();
    print(
        'disposing the transaction with bgcolor ${_randomBackgroundColor.value.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    final double currentAmount = widget.transaction.amount;
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 6,
      ),
      elevation: 6,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _randomBackgroundColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text('\$ ${utility.formatWithFixedString(currentAmount)}'),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          utility.formatDateWithWeekDay(widget.transaction.date),
          style: Theme.of(context).textTheme.headline5,
        ),
        trailing: MediaQuery.of(context).size.width > 400
            ? TextButton.icon(
                onPressed: widget.deleteButtonPressedHandler,
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                label: const Text('Delete'),
              )
            : IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: widget.deleteButtonPressedHandler,
              ),
      ),
    );
  }
}
