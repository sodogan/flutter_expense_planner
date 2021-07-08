import 'package:flutter/material.dart';
import 'package:expense_planner/expense_planner.dart' as utility;

import '/models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteButtonPressedHandler;

  const TransactionList({
    Key? key,
    required this.transactions,
    required this.deleteButtonPressedHandler,
  }) : super(key: key);

  Widget _builder(BuildContext context, int index) {
    final double currentAmount = transactions[index].amount;
    return Card(
      child: FittedBox(
        child: Row(
          children: [
            Container(
              child: Text(
                '\$ ${utility.formatWithFixedString(currentAmount)}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 6,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transactions[index].title,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  utility.formatDateWithWeekDay(transactions[index].date),
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _noTransactionsView({TextStyle? textStyle, required double size}) {
    return Column(
      children: [
        SizedBox(
          height: size * 0.05,
        ),
        Container(
          height: size * 0.1,
          child: Text(
            'No transactions added yet',
            style: textStyle,
          ),
        ),
        SizedBox(
          height: size * 0.05,
        ),
        Container(
          height: size * 0.6,
          child: Image.asset(
            'assets/images/waiting.png',
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return transactions.isEmpty
          ? _noTransactionsView(
              textStyle: Theme.of(context).textTheme.headline6,
              size: constraints.maxHeight)
          : true
              ? ListView(
                  children: [
                    ...transactions.map((Transaction _transaction) {
                      return TransactionItem(
                        key: ValueKey(_transaction.id),
                        transaction: _transaction,
                        deleteButtonPressedHandler: () =>
                            deleteButtonPressedHandler(id: _transaction.id),
                      );
                    }).toList()
                  ],
                )
              : ListView.builder(
                  itemBuilder: (context, int index) {
                    final _transaction = transactions[index];
                    final _key = ValueKey(_transaction.id);
                    print('build is called-transaction item with key ${_key}');
                    return TransactionItem(
                      key: ValueKey(_key),
                      transaction: _transaction,
                      deleteButtonPressedHandler: () =>
                          deleteButtonPressedHandler(index: index),
                    );
                  },
                  itemCount: transactions.length,
                );
    });
  }
}
