import 'package:flutter/material.dart';

class AddQuestionDialog extends StatefulWidget {
  final List<String> list;

  AddQuestionDialog({Key key, this.list}) : super(key: key);

  _AddQuestionDialogState createState() => _AddQuestionDialogState();
}

class _AddQuestionDialogState extends State<AddQuestionDialog> {
  TextEditingController _questionController = TextEditingController();

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Enter a new question"),
      content: TextField(
        onChanged: (value) {
          setState(() {
            _questionController.text = value;
            _questionController.selection = TextSelection.collapsed(
                offset: _questionController.text.length);
          });
        },
        controller: _questionController,
        decoration: InputDecoration(
          hintText: "Your Question...",
          hintStyle: TextStyle(
            color: Colors.black45,
            fontSize: 21.0,
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Save"),
          onPressed: () {
            Navigator.pop(context, _questionController.text);
          },
        ),
        FlatButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
