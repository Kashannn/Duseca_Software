import 'package:dusecasoftware/views/pdf_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Resources/Components/custom_bottom_navigationbar.dart';
import '../Resources/Components/file_picker.dart';
import '../Resources/Components/text_input_dialog.dart';
import '../viewmodels/activity_view_model.dart';
import 'file_screen.dart';
import 'image_screen.dart';

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
        body: Column(
          children: [
            _buildSearchBar(),
            Expanded(
              child: IndexedStack(
                index: _selectedIndex,
                children: _widgetOptions,
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
        floatingActionButton: _buildFloatingActionButton(context),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.5),
            blurRadius: 10.0,
            offset: Offset(10, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.black54),
              ),
              style: TextStyle(color: Colors.black87),
            ),
          ),
          CircleAvatar(
            backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Replace with the user's image URL
            radius: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      elevation: 5.0,
      clipBehavior: Clip.antiAlias,
      foregroundColor: Colors.black,
      onPressed: () {
        _showBottomSheet(context);
      },
      child: Icon(Icons.add),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          height: 200.0, // Set a smaller height for the bottom sheet
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildDialogOption(Icons.image, "Image"),
                  _buildDialogOption(Icons.picture_as_pdf, "PDF"),
                  _buildDialogOption(Icons.file_copy, "File"),
                  _buildDialogOption(Icons.text_fields, "Text"),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDialogOption(IconData icon, String label) {
    ActivityViewModel activityViewModel = Provider.of<ActivityViewModel>(context, listen: false);
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    String userId = user?.uid ?? "defaultUserId"; // Use the current user's ID or a default value

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        if (label == "Image") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ImagePickerWidget(
                onImagePicked: (imageUrl) {
                  print('Image URL: $imageUrl');
                },
              ),
            ),
          );

        } else if (label == "Text") {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return TextInputDialog(
                onSave: (textContent) {
                  activityViewModel.uploadText(textContent, userId);
                },
              );
            },
          );
        }
      },
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 30.0,
            child: Icon(icon, color: Colors.white, size: 30.0),
          ),
          SizedBox(height: 8.0),
          Text(label),
        ],
      ),
    );
  }
}
