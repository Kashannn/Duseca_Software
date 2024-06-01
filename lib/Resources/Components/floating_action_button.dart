import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;

  CustomFloatingActionButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 5.0,
      clipBehavior: Clip.antiAlias,
      foregroundColor: Colors.black,
      onPressed: onPressed,
      child: Icon(Icons.add),
    );
  }
}
