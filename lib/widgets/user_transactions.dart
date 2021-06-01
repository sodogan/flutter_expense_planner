import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './new_transaction.dart';
import './transaction_list.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

//Common denominator for both Card and the Transaction List
class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [];

//we need to notify flutter to rebuild the UI
  addTransaction(Transaction txn) {
    setState(() {
      _userTransactions.add(txn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(
          onPressHandler: addTransaction,
        ),
        TransactionList(
          transactions: _userTransactions,
        ),
      ],
    );
  }
}
