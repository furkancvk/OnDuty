import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:on_duty/models/user_model.dart';
import 'package:on_duty/services/user_service.dart';
import 'package:on_duty/storage/storage.dart';
import 'package:on_duty/widgets/app_alerts.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _userService = UserService();
  final _secureStorage = SecureStorage();

  void logIn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signUp(
      String email,
      String password,
      String firstName,
      String lastName,
      GlobalKey<FormState> formKey,
      ) async {
    if(formKey.currentState!.validate()){
      try {
        final data = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        await data.user?.updateDisplayName("$firstName $lastName");
        final token = await _secureStorage.readSecureData("fcm-token");
        UserModel user = UserModel(
          uid: data.user?.uid,
          firstName: firstName.toLowerCase().trim(),
          lastName: lastName.toLowerCase().trim(),
          email: email.toLowerCase().trim(),
          // tokens: FieldValue.arrayUnion([token]),
          isAdmin: false,
          createdAt: Timestamp.now(),
        );
        _userService.addUser(user);
      } on FirebaseAuthException catch (error) {
        if (error.code == 'email-already-in-use'){
          AppAlerts.toast(message: "Bu email zaten kullanılmaktadır.");
        } else {
          AppAlerts.toast(message: "Bilinmedik bir hata oluştu");
        }
      }
    }
  }

  void logOut() async {
    await _auth.signOut();
  }
}