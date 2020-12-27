import 'package:TestESB/BloC/category_bloc.dart';
import 'package:TestESB/helper/constant.dart';
import 'package:TestESB/model/category_model.dart';
import 'package:TestESB/ui/category_page/category_card.dart';
import 'package:TestESB/widgets/dialogs.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  TextEditingController _categoryController = TextEditingController();

  @override
  void initState() {
    categoryBloc.getCategories();
    super.initState();
  }

  @override
  void dispose() {
    categoryBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StaticString.category),
      ),
      body: StreamBuilder<List<CategoryModel>>(
          stream: categoryBloc.subject,
          builder: (context, snapshot) {
            final List<CategoryModel> _categories = snapshot.data;
            return !snapshot.hasData
                ? Container(child: CircularProgressIndicator())
                : Container(
                    height: MediaQuery.of(context).size.height,
                    child: _categories != null && _categories.length > 0
                        ? ListView.builder(
                            itemCount: _categories.length,
                            itemBuilder: (context, index) =>
                                CategoryCard(model: snapshot.data[index]),
                          )
                        : Center(
                            child: Text(StaticString.dataEmpty),
                          ),
                  );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => FormDialog.input(
            context,
            _categoryController..text = "",
            StaticString.createCategory,
            StaticString.categoryName,
            StaticString.save, () {
          categoryBloc.addCategory(_categoryController.text);
          Navigator.pop(context);
          setState(() {
            categoryBloc.getCategories();
          });
        }, StaticString.cancel, () => Navigator.pop(context)),
        child: Icon(Icons.add),
      ),
    );
  }
}
