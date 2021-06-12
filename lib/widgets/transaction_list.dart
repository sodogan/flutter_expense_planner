import 'package:flutter/material.dart';
import '/models/transaction.dart';
import 'package:expense_planner/expense_planner.dart' as utility;

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList({required this.transactions});

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
                  transactions[index].title,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  utility.formatDateWithWeekDay(transactions[index].date),
                  style: TextStyle(
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      child: transactions.isEmpty
          ? Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "No transactions yet",
                  style: Theme.of(context).textTheme.headline6,
                ),
                Container(
                  height: 100,
                  child: Image.asset(
                    'assets/images/waiting.png',
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: _builder,
              itemCount: transactions.length,
            ),
    );
  }
}
