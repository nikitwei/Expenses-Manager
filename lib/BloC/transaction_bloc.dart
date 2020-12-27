import 'package:TestESB/model/transaction_model.dart';
import 'package:TestESB/services/db_service.dart';
import 'package:rxdart/rxdart.dart';

class TransactionBloc {
  final BehaviorSubject<List<TransactionModel>> _subject =
      BehaviorSubject<List<TransactionModel>>();

  getTransactions() async {
    List<TransactionModel> res = await DBService().getTransactions();
    _subject.sink.add(res);
  }

  addTransaction(TransactionModel model) async {
    await DBService().addTransaction(model);
    getTransactions();
  }

  updateTransaction(TransactionModel model) async {
    await DBService().updateTransaction(model);
    getTransactions();
  }

  deleteTransaction(int id) async {
    await DBService().deleteTransaction(id);
    getTransactions();
  }

  dispose() => _subject.close();

  BehaviorSubject<List<TransactionModel>> get subject => _subject.stream;
  double get balance {
    double res = 0;
    if (subject.hasValue) {
      subject.value.forEach((item) {
        if (item.isIncome)
          res += item.amount;
        else
          res -= item.amount;
      });
    }
    return res;
  }
}

final transactionBloc = TransactionBloc();
