import 'package:flutter/material.dart';

class TextInputDialog extends StatelessWidget {
  final Function(String) onSave;

  TextInputDialog({required this.onSave});

  @override
  Widget build(BuildContext context) {
    String textContent = '';

    return AlertDialog(
      title: Text('Enter Text'),
      content: TextField(
        onChanged: (value) {
          textContent = value;
        },
        decoration: InputDecoration(hintText: "Enter your text here"),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Save'),
          onPressed: () {
            onSave(textContent);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
