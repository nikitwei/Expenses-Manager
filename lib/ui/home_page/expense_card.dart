import 'package:TestESB/helper/styles.dart';
import 'package:TestESB/model/transaction_model.dart';
import 'package:TestESB/ui/update_page/update_page.dart';
import 'package:flutter/material.dart';

class ExpenseCard extends StatelessWidget {
  final bool isIncome;
  final double amount;
  final String category;
  final String description;
  final DateTime transactionDate;
  final TransactionModel model;
  const ExpenseCard(
      {Key key,
      this.isIncome,
      this.amount,
      this.category,
      this.description,
      this.transactionDate,
      this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          leading: Icon(
            isIncome ? Icons.arrow_upward : Icons.arrow_downward,
            color: isIncome ? Colors.green : Colors.red,
            size: 50.0,
          ),
          title: Text(Styles.toIDR(amount)),
          subtitle: Text('$category \n$description'),
          isThreeLine: true,
          trailing: Text(Styles.toIDTime(transactionDate)),
          onTap: () {
            return Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UpdatePage(
                        model: model,
                      )),
            );
          }),
    );
  }
}
