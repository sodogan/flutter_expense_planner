import 'package:flutter/material.dart';
import '/models/transaction.dart';
import 'package:expense_planner/expense_planner.dart' as utility;

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
          : ListView.builder(
              itemBuilder: (context, int index) {
                final double currentAmount = transactions[index].amount;
                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 6,
                  ),
                  elevation: 6,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                              '\$ ${utility.formatWithFixedString(currentAmount)}'),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      utility.formatDateWithWeekDay(transactions[index].date),
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).errorColor,
                      ),
                      onPressed: () => deleteButtonPressedHandler(index),
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            );
    });
  }
}
