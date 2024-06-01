import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/activity_model.dart';
import '../viewmodels/activity_view_model.dart';

class UploadActivityScreen extends StatefulWidget {
  @override
  _UploadActivityScreenState createState() => _UploadActivityScreenState();
}

class _UploadActivityScreenState extends State<UploadActivityScreen> {
  final TextEditingController _textController = TextEditingController();
  List<File> _selectedImages = [];
  List<File> _selectedPdfs = [];

  @override
  Widget build(BuildContext context) {
    final activityViewModel = Provider.of<ActivityViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Upload Activity')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(labelText: 'Text'),
            ),
            ElevatedButton(
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image, allowMultiple: true);
                if (result != null) {
                  setState(() {
                    _selectedImages = result.paths.map((path) => File(path!)).toList();
                  });
                }
              },
              child: Text('Select Images'),
            ),
            ElevatedButton(
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowMultiple: true, allowedExtensions: ['pdf']);
                if (result != null) {
                  setState(() {
                    _selectedPdfs = result.paths.map((path) => File(path!)).toList();
                  });
                }
              },
              child: Text('Select PDFs'),
            ),
            ElevatedButton(
              onPressed: () {
                Activity newActivity = Activity(
                  id: '',
                  text: _textController.text,
                  imageUrls: [],
                  pdfUrls: [],
                  fileUrls: [],
                  textUrls: [],
                );
                activityViewModel.uploadActivity(newActivity, _selectedImages, _selectedPdfs);
              },
              child: Text('Upload Activity'),
            ),
          ],
        ),
      ),
    );
  }
}
