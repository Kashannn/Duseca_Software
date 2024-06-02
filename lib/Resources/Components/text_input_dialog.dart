import 'package:flutter/material.dart';

import '../../utils/routes/routes_name.dart';

class TextInputDialog extends StatelessWidget {
  final Function(String) onSave;

  TextInputDialog({required this.onSave});

  @override
  Widget build(BuildContext context) {
    String textContent = '';

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.yellow.withOpacity(0.5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Enter Text',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'kStyleGrey14400',
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white.withOpacity(0.5),
                ),
                child: TextField(
                  onChanged: (value) {
                    textContent = value;
                  },
                  decoration: InputDecoration(
                    hintText: "Enter your text here",
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                  ),
                  maxLines: 5,
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(width: 8.0),
                  ElevatedButton(
                    child: Text('Save'),
                    onPressed: () {
                      onSave(textContent);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
