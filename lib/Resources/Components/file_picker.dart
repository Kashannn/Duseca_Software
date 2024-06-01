import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerWidget extends StatefulWidget {
  final Function(String) onImagePicked;

  const ImagePickerWidget({required this.onImagePicked, Key? key}) : super(key: key);

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  String? _fileName;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      setState(() {
        _imageFile = file;
        _fileName = pickedFile.name;
      });

      // Upload image to Firebase Storage
      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference storageReference = referenceRoot.child('images/$uniqueFileName');
      try {
        await storageReference.putFile(_imageFile!);
        String imageUrl = await storageReference.getDownloadURL();
        widget.onImagePicked(imageUrl);
      } on FirebaseException catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _fileName == null
                ? Image.asset('assets/Frame.png')
                : Text(
              _fileName!,
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
          ],
        ),
      ),
    );
  }
}
