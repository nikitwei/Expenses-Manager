import 'package:TestESB/helper/constant.dart';
import 'package:TestESB/widgets/dialogs.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final bool isEdit;
  final GlobalKey<FormState> formkey;
  final Function onDelete;
  final Function onSave;
  ActionButton({Key key, this.isEdit, this.formkey, this.onDelete, this.onSave})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      child: Row(children: [
        isEdit
            ? Expanded(
                child: RaisedButton(
                    color: Colors.red,
                    child: Text(
                      StaticString.delete,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
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
                          onDelete();
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      );
                    }),
              )
            : Container(),
        SizedBox(width: 10),
        Expanded(
          child: RaisedButton(
              color: Colors.blue,
              child: Text(
                StaticString.save,
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (formkey.currentState.validate()) {
                  FormDialog.showMessage(
                    context,
                    StaticString.warning,
                    StaticString.confirmSave,
                    StaticString.no,
                    () => Navigator.pop(context),
                    isConfirmationDIalog: true,
                    buttonText2: StaticString.yes,
                    onPressed2: () {
                      onSave();
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  );
                }
              }),
        ),
      ]),
    );
  }
}
