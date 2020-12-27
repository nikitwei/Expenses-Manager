import 'model.dart';

class CategoryModel extends Model {
  static String table = 'categories';

  String categoryName;
  int categoryId;

  CategoryModel({
    this.categoryId,
    this.categoryName,
  });

  static CategoryModel fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryId: map['id'],
      categoryName: map['category_name'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': categoryId,
      'category_name': categoryName,
    };

    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}
