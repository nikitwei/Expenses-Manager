import 'package:TestESB/BloC/transaction_bloc.dart';
import 'package:TestESB/helper/constant.dart';
import 'package:TestESB/helper/routers.dart';
import 'package:TestESB/helper/styles.dart';
import 'package:TestESB/model/transaction_model.dart';
import 'package:TestESB/ui/home_page/expense_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _balance(List<TransactionModel> _models) {
    double result = 0;
    if (_models != null && _models.length > 0) {
      print(_models.length);
      _models.forEach((item) {
        if (item.isIncome) {
          result = result + item.amount;
        } else {
          result = result + item.amount;
        }
      });
    }
    return result;
  }

  @override
  void initState() {
    transactionBloc.getTransactions();
    super.initState();
  }

  @override
  void dispose() {
    transactionBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StaticString.expenseManager),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, Paths.updatepage),
          child: Icon(Icons.add)),
      body: StreamBuilder<List<TransactionModel>>(
          stream: transactionBloc.subject,
          builder: (context, snapshot) {
            final List<TransactionModel> _transactions =
                snapshot.hasData ? snapshot.data : null;
            return !snapshot.hasData
                ? Container(child: CircularProgressIndicator())
                : _transactions != null && _transactions.length > 0
                    ? Column(
                        children: [
                          Card(
                              child: ListTile(
                                  title: Center(
                                      child: Text(
                            StaticString.balance +
                                ': ${Styles.toIDR(transactionBloc.balance)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )))),
                          Container(
                            height: MediaQuery.of(context).size.height / 1.25,
                            child: ListView.builder(
                                itemCount: _transactions.length,
                                itemBuilder: (contex, index) => ExpenseCard(
                                      isIncome: _transactions[index].isIncome,
                                      amount: _transactions[index].amount ?? 0,
                                      category: _transactions[index]
                                              .category
                                              .categoryName ??
                                          "-",
                                      description:
                                          _transactions[index].description ??
                                              "-",
                                      transactionDate: _transactions[index]
                                              .transactionDate ??
                                          "-",
                                      model: _transactions[index],
                                    )),
                          )
                        ],
                      )
                    : Center(
                        child: Text(StaticString.balance +
                            ': ${Styles.toIDR(transactionBloc.balance)}'),
                      );
          }),
    );
  }
}
