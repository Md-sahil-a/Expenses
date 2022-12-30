import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class NewTransaction extends StatefulWidget {
  final Function _addTransation;
  NewTransaction(this._addTransation);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final textController = TextEditingController();

  final amountController = TextEditingController();
  DateTime? showPickedDate;

  void onSubmitted() {
    final enteredTitle = textController.text;
    final enterdAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enterdAmount <= 0 || showPickedDate == null) {
      return;
    }
    widget._addTransation(
      enteredTitle,
      enterdAmount,
      showPickedDate
    );
    Navigator.of(context).pop();
  }

  void showDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime(2019),
      lastDate: DateTime(2040),
      firstDate: DateTime(2019),
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          showPickedDate = pickedDate;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(label: Text('Title')),
              controller: textController,
              onSubmitted: (_) => onSubmitted(),
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                label: Text('Amount'),
              ),
              controller: amountController,
              onSubmitted: (_) => onSubmitted(),
            ),
            Container(
              height: 90,
              child: Row(
                children: [
                  Text(showPickedDate == null
                      ? 'no date choosen'
                      : ' Date: ${DateFormat.yMd().format(showPickedDate)},'),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: showDate,
                    child: const Text('Chose date'),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: onSubmitted,
              child: const Text('Add Transactions'),
            ),
          ],
        ),
      ),
    );
  }
}
