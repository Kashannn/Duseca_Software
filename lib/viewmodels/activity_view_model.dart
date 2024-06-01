

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import '../models/activity_model.dart';

class ActivityViewModel with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  List<Activity> _activities = [];

  List<Activity> get activities => _activities;

  Future<void> fetchActivities() async {
    QuerySnapshot snapshot = await _firestore.collection('activities').orderBy('timestamp', descending: true).get();
    _activities = snapshot.docs.map((doc) => Activity.fromJson(doc.data() as Map<String, dynamic>)).toList();
    notifyListeners();
  }

  Future<void> uploadActivity(Activity activity, List<File> images, List<File> pdfs) async {
    List<String> imageUrls = [];
    List<String> pdfUrls = [];

    // Upload images
    for (File image in images) {
      String imageUrl = await _uploadFile(image, 'images');
      imageUrls.add(imageUrl);
    }

    // Upload PDFs
    for (File pdf in pdfs) {
      String pdfUrl = await _uploadFile(pdf, 'pdfs');
      pdfUrls.add(pdfUrl);
    }

    // Add activity to Firestore
    Activity newActivity = Activity(
      id: '',
      text: activity.text,
      imageUrls: imageUrls,
      pdfUrls: pdfUrls,
      fileUrls: [],
      textUrls: [],
    );
    DocumentReference docRef = await _firestore.collection('activities').add(newActivity.toJson());
    newActivity.id = docRef.id;
    _activities.insert(0, newActivity);
    notifyListeners();
  }

  Future<String> _uploadFile(File file, String folder) async {
    String fileName = '${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
    Reference ref = _storage.ref().child('$folder/$fileName');
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }
}
