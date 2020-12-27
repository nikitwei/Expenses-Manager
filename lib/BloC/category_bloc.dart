import 'package:TestESB/model/category_model.dart';
import 'package:TestESB/services/db_service.dart';
import 'package:rxdart/rxdart.dart';

class CategoryBloc {
  final BehaviorSubject<List<CategoryModel>> _subject =
      BehaviorSubject<List<CategoryModel>>();
  final BehaviorSubject<CategoryModel> _subjectCategory =
      BehaviorSubject<CategoryModel>();

  getCategories() async {
    if (!_subject.isClosed) {
      List<CategoryModel> res = await DBService().getCategories();
      _subject.sink.add(res);
    }
  }

  getCategory(int id) async {
    if (!_subjectCategory.isClosed) {
      CategoryModel res = await DBService().getCategory(id);
      _subjectCategory.sink.add(res);
    }
  }

  addCategory(String name) async {
    CategoryModel _model = CategoryModel();
    _model.categoryName = name;
    await DBService().addCategory(_model);
    getCategories();
  }

  updateCategory(CategoryModel model) async {
    await DBService().updateCategory(model);
    getCategories();
  }

  deleteCategory(CategoryModel model) async {
    await DBService().deleteCategory(model.categoryId);
    getCategories();
  }

  BehaviorSubject<List<CategoryModel>> get subject => _subject.stream;
  BehaviorSubject<CategoryModel> get subjectCategory => _subjectCategory.stream;

  dispose() => _subject.close();
  disposeCategory() => _subjectCategory.close();
}

final categoryBloc = CategoryBloc();
