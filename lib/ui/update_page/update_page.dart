import 'dart:convert';
import 'dart:ffi';

import 'package:TestESB/BloC/category_bloc.dart';
import 'package:TestESB/BloC/transaction_bloc.dart';
import 'package:TestESB/helper/constant.dart';
import 'package:TestESB/helper/styles.dart';
import 'package:TestESB/model/category_model.dart';
import 'package:TestESB/model/transaction_model.dart';
import 'package:TestESB/ui/category_page/category_page.dart';
import 'package:TestESB/ui/update_page/action_button.dart';
import 'package:TestESB/widgets/custom_switch.dart';
import 'package:TestESB/ui/update_page/input_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpdatePage extends StatefulWidget {
  final TransactionModel model;
  UpdatePage({Key key, this.model}) : super(key: key);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final _formKey = GlobalKey<FormState>();
  final Map<bool, Widget> options = const <bool, Widget>{
    false: Text("Expenses"),
    true: Text("Income")
  };
  TransactionModel _transaction = TransactionModel(
      isIncome: false,
      transactionDate: DateTime.now(),
      category: CategoryModel(categoryId: null, categoryName: ""),
      amount: 0,
      description: "");
  TextEditingController _trnasactionDate = TextEditingController(),
      _categoryName = TextEditingController(),
      _amount = TextEditingController(),
      _description = TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _transaction.transactionDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != _transaction.transactionDate)
      setState(() {
        _transaction.transactionDate = picked;
        _trnasactionDate.value =
            TextEditingValue(text: Styles.toIDTime(picked));
      });
  }

  Future<Null> _selectCategory(BuildContext context) async {
    final CategoryModel newCategory = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CategoryPage()),
    );
    if (newCategory != null)
      setState(() {
        _transaction.category = newCategory;
        _transaction.categoryId = newCategory.categoryId;
        _categoryName.value = TextEditingValue(text: newCategory.categoryName);
      });
  }

  @override
  void initState() {
    if (widget.model != null) {
      _transaction = widget.model;
    }
    _trnasactionDate.value =
        TextEditingValue(text: Styles.toIDTime(_transaction.transactionDate));
    _categoryName.value =
        TextEditingValue(text: _transaction.category.categoryName);
    _amount.value = TextEditingValue(text: _transaction.amount.toString());
    _description.value = TextEditingValue(text: _transaction.description);
    super.initState();
  }

  @override
  void dispose() {
    categoryBloc.disposeCategory();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_transaction.id == null
              ? StaticString.createTransaction
              : StaticString.updateTransaction),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(children: [
              CustomSwitch(
                value: _transaction.isIncome,
                textTrue: StaticString.income,
                textFalse: StaticString.expense,
                onTap: () {
                  setState(() {
                    _transaction.isIncome = !_transaction.isIncome;
                  });
                },
              ),
              Form(
                  key: _formKey,
                  child: Wrap(children: [
                    GestureDetector(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                            child: IntputText(
                          controller: _trnasactionDate,
                          labelText: StaticString.transactionDate,
                        ))),
                    GestureDetector(
                      onTap: () => _selectCategory(context),
                      child: AbsorbPointer(
                        child: IntputText(
                          controller: _categoryName,
                          labelText: StaticString.category,
                        ),
                      ),
                    ),
                    IntputText(
                      controller: _amount,
                      labelText: StaticString.amount,
                      onChanged: (value) {
                        _transaction.amount = double.parse(value);
                      },
                    ),
                    IntputText(
                      controller: _description,
                      labelText: StaticString.description,
                      onChanged: (value) {
                        _transaction.description = value;
                      },
                    ),
                    ActionButton(
                      isEdit: _transaction.id != null,
                      formkey: _formKey,
                      onDelete: () {
                        transactionBloc.deleteTransaction(_transaction.id);
                      },
                      onSave: () {
                        _transaction.id != null
                            ? transactionBloc.updateTransaction(_transaction)
                            : transactionBloc.addTransaction(_transaction);
                      },
                    )
                  ]))
            ])));
  }
}
