import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';
import './models/transaction_summary.dart';
import 'package:expense_planner/expense_planner.dart' as utility;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Planner',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Quicksand',
        errorColor: Colors.purple,
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(
                fontFamily: 'OpenSans',
                color: Colors.white,
                fontSize: 18,
              ),
            ),
        accentColor: Colors.indigo,
        appBarTheme: AppBarTheme(
          elevation: 12,
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String _pageTitle = 'Expense Planner';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];

  /// Adds a new transaction to the list and sets the state
  void _addNewTransaction({
    required String title,
    required double amount,
    required DateTime dateTime,
  }) {
    // Create uuid object
    final uuid = const Uuid();

    //create a new Transaction
    final _newTransaction = Transaction(
      id: uuid.v1(),
      title: title,
      amount: amount,
      date: dateTime,
    );

    print("Adding a new transaction: $_newTransaction");

    setState(() {
      _userTransactions.add(_newTransaction);
    });
  }

  void _deleteTransaction(int index) {
    setState(() => _userTransactions.removeAt(index));
  }

//Gets the recent transactions
  List<TransactionSummary> get weeklyTransactionSummary {
    print("trying to get one weeks of trsansactions");
    final List<Map<String, Object>> mappedTransactions =
        _buildMatchingTransactionsMap();

//Build the transaction summary
    final List<TransactionSummary> transactionSummaryList =
        mappedTransactions.map((Map<String, Object> entry) {
      return new TransactionSummary.fromJSON(entry);
    }).toList();

//sort it based on the date ascending
    transactionSummaryList.sort((TransactionSummary a, TransactionSummary b) =>
        a.dateTime.compareTo(b.dateTime));

    print(transactionSummaryList);
    return transactionSummaryList;
  }

  List<Map<String, Object>> _buildMatchingTransactionsMap() {
    List<DateTime> datesList = utility.generateWeekList();

    List<Map<String, Object>> result = [];
    for (var date in datesList) {
      //print(date);

      List<Transaction> filtered = _userTransactions
          .where((Transaction transaction) =>
              (date.year == transaction.date.year &&
                  date.month == transaction.date.month &&
                  date.day == transaction.date.day))
          .toList();

      final double totalSum =
          filtered.fold(0, (sum, current) => sum + current.amount);

      //result[date] = filtered;
      result.add({"dateTime": date, "totalSum": totalSum});
    }
    return result;
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
            '${widget._pageTitle}',
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
        //mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Chart(
            weeklyTransactionSummary: weeklyTransactionSummary,
          ),
          TransactionList(
            transactions: _userTransactions,
            deleteButtonPressedHandler: _deleteTransaction,
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
