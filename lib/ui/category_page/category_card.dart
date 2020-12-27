import 'package:TestESB/BloC/category_bloc.dart';
import 'package:TestESB/helper/constant.dart';
import 'package:TestESB/model/category_model.dart';
import 'package:TestESB/widgets/dialogs.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel model;
  const CategoryCard({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          title: Text(model.categoryName),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              FormDialog.showMessage(
                context,
                StaticString.warning,
                StaticString.confirmDelete,
                StaticString.no,
                () => Navigator.pop(context),
                isConfirmationDIalog: true,
                buttonText2: StaticString.yes,
                onPressed2: () {
                  categoryBloc.deleteCategory(model);
                  Navigator.pop(context);
                },
              );
            },
          ),
          onTap: () {
            return Navigator.pop(context, model);
          }),
    );
  }
}
