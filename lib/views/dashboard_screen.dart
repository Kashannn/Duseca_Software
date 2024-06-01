import 'package:flutter/material.dart';
import '../Resources/Components/bottom_sheet_dialog.dart';
import '../Resources/Components/custom_bottom_navigationbar.dart';
import '../Resources/Components/floating_action_button.dart';
import '../Resources/Components/search_bar.dart';
import 'file_screen.dart';
import 'image_screen.dart';
import 'pdf_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    FileScreen(),
    ImageScreen(),
    PdfScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              customSearchBar(),
              Expanded(
                child: IndexedStack(
                  index: _selectedIndex,
                  children: _widgetOptions,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
        floatingActionButton: CustomFloatingActionButton(
          onPressed: () => showBottomSheetDialog(context),
        ),
      ),
    );
  }
}
