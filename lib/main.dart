import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Planner',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.indigo,
        appBarTheme: AppBarTheme(
          elevation: 12,
          color: Colors.indigo,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  static const String _pageTitle = 'Expense Planner';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];

  /// Adds a new transaction to the list and sets the state
  void _addNewTransaction({required String title, required double amount}) {
    // Create uuid object
    var uuid = Uuid();

    //create a new Transaction
    final _newTransaction = Transaction.now(
      id: uuid.v1(),
      title: title,
      amount: amount,
    );

    print("Adding a new transaction: $_newTransaction");

    setState(() {
      _userTransactions.add(_newTransaction);
    });
  }

  void _displayNewTransactionModal(
    BuildContext cntx,
  ) {
    showModalBottomSheet<String>(
      context: cntx,
      builder: (BuildContext bctx) {
        return GestureDetector(
          onTap: () {
            print("Tap is pressed");
            //Navigator.pop(bctx);
          },
          onDoubleTap: () {
            print("Double Tap is pressed");
          },
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(
            addNewTransactionHandler: _addNewTransaction,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            MyHomePage._pageTitle,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
            ),
            onPressed: () => _displayNewTransactionModal(context),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Chart(),
          TransactionList(
            transactions: _userTransactions,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () => _displayNewTransactionModal(context),
      ),
    );
  }
}
