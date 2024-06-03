import 'dart:io';

import 'package:dusecasoftware/views/note_screen.dart';
import 'package:dusecasoftware/views/pdf_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Resources/Components/custom_bottom_navigationbar.dart';
import '../Resources/Components/floating_action_button.dart';
import '../Resources/Components/search_bar.dart';
import '../Resources/Components/text_input_dialog.dart';
import '../viewmodels/activity_view_model.dart';

import 'image_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    ImageScreen(key: ImageScreen.globalKey),
    PdfScreen(key: PdfScreen.globalKey),
    NoteScreen(key: NoteScreen.globalKey),
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
            customSearchBar(),
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
        floatingActionButton:
            CustomFloatingActionButton(onPressed: showBottomSheet),
      ),
    );
  }

  void showBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(20.0),
          right: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 120.0,
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
    ActivityViewModel activityViewModel =
        Provider.of<ActivityViewModel>(context, listen: false);
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    String userId = user?.uid ?? "defaultUserId";

    return GestureDetector(
      onTap: () async {
        Navigator.of(context).pop();
        if (label == "Image") {
          FilePickerResult? result =
              await FilePicker.platform.pickFiles(type: FileType.image);
          if (result != null) {
            File imageFile = File(result.files.single.path!);
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Confirm Upload'),
                  content: Text('Do you want to upload this image file?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        activityViewModel.uploadImage(imageFile, userId).then((_) {
                          ImageScreen.globalKey.currentState?.refreshImages();
                        });
                      },
                      child: Text('Upload'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel'),
                    ),
                  ],
                );
              },
            );
          }
        } else if (label == "Text") {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return TextInputDialog(
                onSave: (textContent) {
                  activityViewModel.uploadText(textContent, userId).then((_) {
                    // Refresh note screen
                    NoteScreen.globalKey.currentState?.refreshNotes();
                  });
                },
              );
            },
          );
        } else if (label == "PDF") {
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['pdf'],
          );
          if (result != null) {
            File pdfFile = File(result.files.single.path!);
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Confirm Upload'),
                  content: Text('Do you want to upload this PDF file?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        activityViewModel.uploadPdf(pdfFile, userId).then((_) {
                          PdfScreen.globalKey.currentState?.refreshPdfs();
                        });
                      },
                      child: Text('Upload'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel'),
                    ),
                  ],
                );
              },
            );
          }
        } else if (label == "File") {
          // Implement the file upload functionality here
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 40.0),
          Text(label),
        ],
      ),
    );
  }
}
