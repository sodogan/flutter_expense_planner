import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:expense_planner/expense_planner.dart' as utility;

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/custom_theme.dart';
import './widgets/chart.dart';
import './models/transaction.dart';
import './models/transaction_summary.dart';

void main() {
/* For forcing only portrait mode !
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ],
  ).then(
    (_) => runApp(MyApp()),
  );
 */
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Planner',
      theme: myCustomLightTheme(),
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
  var _isShowChart = false;

  /// Adds a new transaction to the list and sets the state
  void _addNewTransaction({
    required String title,
    required double amount,
    required DateTime dateTime,
  }) {
    //create a new Transaction
    final _newTransaction = Transaction(
      id: const Uuid().v1(),
      title: title,
      amount: amount,
      date: dateTime,
    );

    print('Adding a new transaction: $_newTransaction');

    setState(() {
      _userTransactions.add(_newTransaction);
    });
  }

  void _deleteTransaction(int index) {
    setState(() => _userTransactions.removeAt(index));
  }

  void _changeSwitchMode(bool mode) {
    setState(() {
      _isShowChart = mode;
    });
  }

//Gets the recent transactions
  List<TransactionSummary> get weeklyTransactionSummary {
    final List<Map<String, Object>> mappedTransactions =
        _buildMatchingTransactionsMap();

//Build the transaction summary
    final List<TransactionSummary> transactionSummaryList =
        mappedTransactions.map((Map<String, Object> entry) {
      return TransactionSummary.fromJSON(entry);
    }).toList();

//sort it based on the date ascending
    transactionSummaryList.sort(
      (TransactionSummary a, TransactionSummary b) => a.dateTime.compareTo(
        b.dateTime,
      ),
    );

    // ignore: avoid_print
    print(transactionSummaryList);
    return transactionSummaryList;
  }

  List<Map<String, Object>> _buildMatchingTransactionsMap() {
//    List<DateTime> datesList = utility.generateWeekList();
    final _weekList = utility.weeklyListGenerator();

    final List<Map<String, Object>> result = [];
    var _dailySum = 0.0;
    for (final date in _weekList) {
      Iterable<Transaction> _filtered = _userTransactions.where(
        (Transaction transaction) => (date.year == transaction.date.year &&
            date.month == transaction.date.month &&
            date.day == transaction.date.day),
      );

      _dailySum = _filtered.isNotEmpty
          ? _filtered.fold(0, (sum, current) => sum + current.amount)
          : 0.0;

      result.add(
        {
          'dateTime': date,
          'dailySum': _dailySum,
        },
      );
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
            print('Tap is pressed');
            //Navigator.pop(bctx);
          },
          onDoubleTap: () {
            print('Double Tap is pressed');
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
    final _appBar = AppBar(
      title: Center(
        child: Text(
          widget._pageTitle,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.add,
          ),
          onPressed: () => _displayNewTransactionModal(context),
        ),
      ],
    );

    final _logicalSize = MediaQuery.of(context).size;
    final _statusBarHeight = MediaQuery.of(context).padding.top;
    final _appBarHeight = _appBar.preferredSize.height;
    final _remainingHeight =
        (_logicalSize.height - _appBarHeight - _statusBarHeight);

    final _isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape
            ? true
            : false;

    final List<Widget> _portraitModeWidgetList = <Widget>[
      Container(
        height: _remainingHeight * 0.30,
        child: Chart(
          weeklyTransactionSummary: weeklyTransactionSummary,
        ),
      ),
      Container(
        height: _remainingHeight * 0.70,
        child: TransactionList(
          transactions: _userTransactions,
          deleteButtonPressedHandler: _deleteTransaction,
        ),
      ),
    ];

    final List<Widget> _landscapeModeWidgetList = <Widget>[
      Container(
        height: _remainingHeight * 0.2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Show Chart'),
            Switch.adaptive(
              value: _isShowChart,
              onChanged: _changeSwitchMode,
              activeColor: Theme.of(context).colorScheme.secondary,
            ),
          ],
        ),
      ),
      if (_isShowChart)
        Container(
          height: _remainingHeight * 0.6,
          child: Chart(
            weeklyTransactionSummary: weeklyTransactionSummary,
          ),
        ),
      if (!_isShowChart)
        Container(
          height: _remainingHeight * 0.7,
          child: TransactionList(
            transactions: _userTransactions,
            deleteButtonPressedHandler: _deleteTransaction,
          ),
        ),
    ];

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  if (!_isLandscape) ..._portraitModeWidgetList,
                  if (_isLandscape) ..._landscapeModeWidgetList,
                ],
              ),
            ),
          )
        : Scaffold(
            appBar: _appBar,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  if (!_isLandscape) ..._portraitModeWidgetList,
                  if (_isLandscape) ..._landscapeModeWidgetList,
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: const Icon(
                      Icons.add,
                    ),
                    onPressed: () => _displayNewTransactionModal(context),
                  ),
          );
  }
}
