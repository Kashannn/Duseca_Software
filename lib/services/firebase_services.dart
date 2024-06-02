import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/activity_model.dart';
import '../models/user_model.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> signUp(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> addUserToFirestore(UserModel user) async {
    await _firestore.collection('users').doc(user.uid).set(user.toMap());
  }

  Future<UserCredential> signIn(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserModel> getUserFromFirestore(String uid) async {
    DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
    return UserModel.fromMap(doc.data() as Map<String, dynamic>);
  }

  Future<List<Map<String, String>>> getAllImagesUrlsAndNames() async {
    List<Map<String, String>> images = [];
    try {
      String id = _auth.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection('activities')
          .doc('images')
          .get();

      if (docSnapshot.exists) {
        List<dynamic> files = docSnapshot.data()!['files'] as List<dynamic>;
        for (var file in files) {
          var fileMap = file as Map<String, dynamic>;
          images.add({
            'name': fileMap['fileName'] as String,
            'url': fileMap['fileUrl'] as String,
          });
        }
      }
    } catch (e) {
      print('Error fetching images: $e');
    }

    return images;
  }

  Future<List<Map<String, String>>> getAllPdfUrlsAndNames() async {
    List<Map<String, String>> pdfs = [];
    try {
      String id = _auth.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection('activities')
          .doc('pdfs')
          .get();

      if (docSnapshot.exists) {
        List<dynamic> files = docSnapshot.data()!['files'] as List<dynamic>;
        for (var file in files) {
          var fileMap = file as Map<String, dynamic>;
          pdfs.add({
            'name': fileMap['fileName'] as String,
            'url': fileMap['fileUrl'] as String,
          });
        }
      }
    } catch (e) {
      print('Error fetching PDFs: $e');
    }

    return pdfs;
  }

  Future<List<Map<String, String>>> getAllText() async {
    List<Map<String, String>> texts = [];
    try {
      String id = _auth.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection('activities')
          .doc('texts')
          .get();

      if (docSnapshot.exists) {
        List<dynamic> textContents = docSnapshot.data()!['textContents'] as List<dynamic>;
        for (var text in textContents) {
          texts.add({'text': text as String});
        }
      }
    } catch (e) {
      print('Error fetching texts: $e');
    }

    return texts;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

}


