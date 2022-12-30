import 'package:expenses/model/transaction.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function delete;

  TransactionList(this.transactions, this.delete);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
          ? Column(
              children: [
                const Text(
                  'Transaction not Added',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 250,
                  child: Image.asset(
                    'assets/images/notfound.gif',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 6,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: FittedBox(
                          child: Text('\$ ${transactions[index].amount}')),
                    ),
                    title: Text(transactions[index].title.toString()),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: (() => delete(transactions[index].id)),
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}


// Card(
//                   child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           margin: const EdgeInsets.symmetric(
//                             vertical: 10.0,
//                             horizontal: 15.0,
//                           ),
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                                 color: Theme.of(context).primaryColor,
//                                 width: 2),
//                           ),
//                           padding: const EdgeInsets.all(10),
//                           child: Text(
//                               style: const TextStyle(
//                                 color: Colors.purple,
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               '\$ ${transactions[index].amount}'),
//                         ),
//                         Column(
//                           children: [
//                             Text(
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 30,
//                                 color: Theme.of(context).primaryColor,
//                               ),
//                               transactions[index].title.toString(),
//                             ),
//                             Text(
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 15,
//                                   color: Theme.of(context).primaryColor,
//                                 ),
//                                 DateFormat.yMMMEd()
//                                     .format(transactions[index].date)),
//                           ],
//                         ),
//                       ]),
//                 );