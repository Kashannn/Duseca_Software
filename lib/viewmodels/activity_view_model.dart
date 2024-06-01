import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../models/activity_model.dart';

class ActivityViewModel with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> uploadImage(File image, String userId) async {
    try {
      String imageUrl = await _uploadFile(image, 'images');
      await _updateUserFiles(userId, imageUrl, 'images');
      notifyListeners();
    } catch (e) {
      print('Upload image error: $e');
    }
  }

  Future<void> uploadPdf(File pdf, String userId) async {
    try {
      String pdfUrl = await _uploadFile(pdf, 'pdfs');
      await _updateUserFiles(userId, pdfUrl, 'pdfs');
      notifyListeners();
    } catch (e) {
      print('Upload PDF error: $e');
    }
  }

  Future<void> uploadText(String textContent, String userId) async {
    try {
      await _updateUserTexts(userId, textContent);
      notifyListeners();
    } catch (e) {
      print('Upload text error: $e');
    }
  }

  Future<void> _updateUserFiles(String userId, String fileUrl, String fileType) async {
    try {
      DocumentReference userRef = _firestore.collection('users').doc(userId).collection('activities').doc(fileType);
      await userRef.set({
        fileType == 'images' ? 'imageUrls' : 'pdfUrls': FieldValue.arrayUnion([fileUrl]),
      }, SetOptions(merge: true));
    } catch (e) {
      print('Update user files error: $e');
      throw e;
    }
  }

  Future<void> _updateUserTexts(String userId, String textContent) async {
    try {
      DocumentReference userRef = _firestore.collection('users').doc(userId).collection('activities').doc('texts');
      await userRef.set({
        'textContents': FieldValue.arrayUnion([textContent]),
      }, SetOptions(merge: true));
    } catch (e) {
      print('Update user texts error: $e');
      throw e;
    }
  }

  Future<String> _uploadFile(File file, String folder) async {
    try {
      String fileName = '${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
      Reference ref = _storage.ref().child('$folder/$fileName');
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot taskSnapshot = await uploadTask;
      return await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      print('File upload error: $e');
      throw e;
    }
  }
}