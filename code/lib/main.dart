// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:expenses/widgets/chart.dart';
import 'package:expenses/widgets/newtransaction.dart';
import 'package:expenses/widgets/transactionlist.dart';
import 'package:flutter/material.dart';
import 'model/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
            .copyWith(secondary: Colors.amber),
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> transaction = [
    // Transaction(
    //   id: '1',
    //   title: 'newShoes',
    //   amount: 20,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: '2',
    //   title: 'Bag',
    //   amount: 30,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransaction {
    return transaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addTransation(String title, double amount, DateTime chosenDate) {
    final newtx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: chosenDate,
    );
    setState(() {
      transaction.add(newtx);
    });
  }

  void deleteItem(String id) {
    setState(() {
      transaction.removeWhere((element) => element.id == id);
    });
  }

  void showTransactionModal(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (ctx) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addTransation),
          );
        });
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffff),
      appBar: AppBar(
        title: const Text('Expenses'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: (() => showTransactionModal(context)),
          ),
        ],
      ),
      body: Column(children: [
        Container(
          color: Colors.blue,
          width: double.infinity,
          child: const Card(
            color: Colors.amber,
            child: Text('Card'),
          ),
        ),
        TransactionList(transaction, deleteItem),
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (() => showTransactionModal(context)),
        child: const Icon(Icons.add),
      ),
    );
  }
}
