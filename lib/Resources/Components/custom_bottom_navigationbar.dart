import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  CustomBottomNavigationBar({required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(

        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.5),
            blurRadius: 10.0,
            offset: Offset(0, -10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: BottomNavigationBar(
          // Background color of the BottomNavigationBar
          selectedItemColor: Colors.black, // Color of the selected item
          unselectedItemColor: Colors.blueGrey, // Color of unselected items
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.file_copy),
              label: 'File',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.image),
              label: 'Image',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.picture_as_pdf),
              label: 'PDF',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.text_fields),
              label: 'Text',
            ),
          ],
          currentIndex: selectedIndex,
          onTap: onItemTapped,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
