

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/user_model.dart';
import '../services/firebase_services.dart';

class AuthViewModel with ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  UserModel? _user;

  UserModel? get user => _user;

  Future<void> signUp(String email, String password, String name) async {
    try {
      UserCredential userCredential = await _firebaseService.signUp(email, password);
      _user = UserModel(uid: userCredential.user!.uid, email: email, name: name);
      await _firebaseService.addUserToFirestore(_user!);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseService.signIn(email, password);
      _user = await _firebaseService.getUserFromFirestore(userCredential.user!.uid);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> signOut() async {
    await _firebaseService.signOut();
    _user = null;
    notifyListeners();
  }
}
