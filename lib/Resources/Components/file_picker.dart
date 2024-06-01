import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import '../../viewmodels/auth_view_model.dart';

class ImagePickerWidget extends StatefulWidget {
  final Function(String) onImagePicked;

  const ImagePickerWidget({required this.onImagePicked, Key? key}) : super(key: key);

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  String imageUrl = '';
  String? _fileName;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);

      setState(() {
        _imageFile = file;
        _fileName = pickedFile.name; // Store the file name
      });

      // Upload image to Firebase Storage
      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference storageReference = referenceRoot.child('Image');
      Reference referenceImageToUpload = storageReference.child(uniqueFileName);
      try {
        await referenceImageToUpload.putFile(_imageFile!);
        imageUrl = await referenceImageToUpload.getDownloadURL();
        widget.onImagePicked(imageUrl); // Pass the image URL to the parent widget
      } on FirebaseException catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthViewModel authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      body: GestureDetector(
        onTap: _pickImage,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _fileName == null
                  ? Image.asset(
                'assets/Frame.png', // Path to your placeholder image
              )
                  : Text(
                _fileName!, // Display the file name
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Add Profile Photo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async{
                      _pickImage();
                      try {

                      } catch (e) {
                        print(e);
                      }
                    },
                    child: const Text('Upload Image'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
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
