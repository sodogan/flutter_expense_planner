import 'package:flutter/material.dart';
import './transaction.dart' show Transaction;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction.now(id: "t1", title: "New Shoes", amount: 69.99),
    Transaction.now(id: "t2", title: "New Book", amount: 19.99),
    Transaction.now(id: "t3", title: "New Bicycle", amount: 420.99),
    Transaction.now(id: "t4", title: "New Shampoo", amount: 29.99),
  ];

  List<Widget> mappedList() {
    var result = transactions.map((e) => Card(child: Text(e.title))).toList();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: Card(
              child: Text("Chart"),
              color: Colors.blue,
              elevation: 12,
            ),
            width: double.infinity,
            height: 35,
          ),
          Column(children: [
            ...mappedList(),
          ]),
        ],
      ),
    );
  }
}
