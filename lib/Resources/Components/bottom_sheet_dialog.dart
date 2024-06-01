import 'dart:io';
import 'package:dusecasoftware/Resources/Components/text_input_dialog.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../viewmodels/activity_view_model.dart';

void showBottomSheetDialog(BuildContext context) {
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
                _buildDialogOption(context, Icons.image, "Image"),
                _buildDialogOption(context, Icons.picture_as_pdf, "PDF"),
                _buildDialogOption(context, Icons.file_copy, "File"),
                _buildDialogOption(context, Icons.text_fields, "Text"),
              ],
            ),
          ],
        ),
      );
    },
  );
}

Widget _buildDialogOption(BuildContext context, IconData icon, String label) {
  ActivityViewModel activityViewModel =
  Provider.of<ActivityViewModel>(context, listen: false);
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  String userId = user?.uid ?? "defaultUserId"; // Use the current user's ID or a default value

  return GestureDetector(
    onTap: () async {
      Navigator.of(context).pop();
      if (label == "Image") {
        FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
        if (result != null) {
          File imageFile = File(result.files.single.path!);
          _showConfirmUploadDialog(
            context,
            'Confirm Upload',
            'Do you want to upload this image file?',
                () {
              activityViewModel.uploadImage(imageFile, userId);
            },
          );
        }
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
      } else if (label == "PDF") {
        FilePickerResult? result = await FilePicker.platform
            .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
        if (result != null) {
          File pdfFile = File(result.files.single.path!);
          _showConfirmUploadDialog(
            context,
            'Confirm Upload',
            'Do you want to upload this PDF file?',
                () {
              activityViewModel.uploadPdf(pdfFile, userId);
            },
          );
        }
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

void _showConfirmUploadDialog(BuildContext context, String title, String content, VoidCallback onUpload) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onUpload();
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
