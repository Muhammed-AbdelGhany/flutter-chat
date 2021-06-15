import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthProvider with ChangeNotifier {
  final _auth = FirebaseAuth.instance;

  String _errorMsg;

  String get errorMsg => _errorMsg;

  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      notifyListeners();
      return authResult;
    } on FirebaseAuthException catch (e) {
      print('from provider exxx');
      _errorMsg = " Auth error";
      Fluttertoast.showToast(
          msg: _errorMsg,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.red,
          gravity: ToastGravity.SNACKBAR);
      // if (e.toString().contains("")) _errorMsg = e.toString();

      throw e;
    }
  }

  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password, String username) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.user.uid)
          .set({'username': username, 'email': email});
      notifyListeners();
      return authResult;
    } on FirebaseAuthException catch (e) {
      _errorMsg = " Auth error";
      Fluttertoast.showToast(
          msg: _errorMsg,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.red,
          gravity: ToastGravity.SNACKBAR);
      // if (e.toString().contains("")) _errorMsg = e.toString();
      notifyListeners();

      throw e;
    }
  }
}
