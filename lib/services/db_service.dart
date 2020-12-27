import 'package:TestESB/helper/db_helper.dart';
import 'package:TestESB/model/category_model.dart';
import 'package:TestESB/model/transaction_model.dart';

class DBService {
  Future<List<TransactionModel>> getTransactions() async {
    await DB.init();
    List<Map<String, dynamic>> items = await DB.items(TransactionModel.table);

    items.map((value) => TransactionModel.fromMap(value)).toList();
    List<TransactionModel> newItems =
        items.map((value) => TransactionModel.fromMap(value)).toList();
    for (int index = 0; index < newItems.length; index++) {
      newItems[index].category = await getCategory(newItems[index].categoryId);
    }
    return newItems;
  }

  Future<TransactionModel> getTransaction(int id) async {
    await DB.init();
    Map<String, dynamic> item = await DB.item(TransactionModel.table, id);
    return TransactionModel.fromMap(item);
  }

  Future<bool> addTransaction(TransactionModel model) async {
    await DB.init();
    bool isSaved = false;
    if (model != null) {
      int inserted = await DB.insert(TransactionModel.table, model);
      isSaved = inserted == 1;
    }
    return isSaved;
  }

  Future<bool> updateTransaction(TransactionModel model) async {
    await DB.init();
    bool isSaved = false;
    if (model != null) {
      int updated = await DB.update(TransactionModel.table, model);
      isSaved = updated == 1;
    }
    return isSaved;
  }

  Future<bool> deleteTransaction(int id) async {
    await DB.init();
    bool isSaved = false;
    if (id != null && id > 0) {
      int deleted = await DB.delete(TransactionModel.table, id);
      isSaved = deleted == 1;
    }
    return isSaved;
  }

  Future<List<CategoryModel>> getCategories() async {
    await DB.init();
    List<Map<String, dynamic>> items = await DB.items(CategoryModel.table);
    return items.map((item) => CategoryModel.fromMap(item)).toList();
  }

  Future<CategoryModel> getCategory(int id) async {
    await DB.init();
    Map<String, dynamic> item = await DB.item(CategoryModel.table, id);
    return CategoryModel.fromMap(item);
  }

  Future<bool> addCategory(CategoryModel model) async {
    await DB.init();
    bool isSaved = false;
    if (model != null) {
      int inserted = await DB.insert(CategoryModel.table, model);
      isSaved = inserted != 0;
    }
    return isSaved;
  }

  Future<bool> updateCategory(CategoryModel model) async {
    await DB.init();
    bool isSaved = false;
    if (model != null) {
      int updated = await DB.update(CategoryModel.table, model);
      isSaved = updated == 1;
    }
    return isSaved;
  }

  Future<bool> deleteCategory(int id) async {
    await DB.init();
    bool isSaved = false;
    if (id != null && id > 0) {
      int deleted = await DB.delete(CategoryModel.table, id);
      isSaved = deleted > 0;
    }
    return isSaved;
  }
}
