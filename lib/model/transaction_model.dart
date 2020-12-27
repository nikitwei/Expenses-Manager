import 'package:TestESB/model/category_model.dart';
import 'package:TestESB/model/model.dart';

class TransactionModel extends Model {
  static String table = "transactions";

  int id;
  bool isIncome;
  DateTime transactionDate;
  int categoryId;
  CategoryModel category;
  double amount;
  String description;

  TransactionModel({
    this.id,
    this.isIncome,
    this.transactionDate,
    this.categoryId,
    this.category,
    this.amount,
    this.description,
  });

  static TransactionModel fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      isIncome: map['is_income'] == 1,
      transactionDate: DateTime.parse(map['transaction_date']),
      categoryId: map['category_id'],
      amount: map['amount'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'is_income': isIncome ? 1 : 0,
      'transaction_date': transactionDate.toString(),
      'category_id': categoryId,
      'amount': amount,
      'description': description,
    };

    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}
