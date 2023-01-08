import 'package:flutter/cupertino.dart';

class States with ChangeNotifier {
  bool isAdmin = false;
  bool isAuth = false;

  bool newNotification = false;

  void changeNewNotification(bool value){
    newNotification = value;
    notifyListeners();
  }

  void setIsAdmin(bool isAdmin){
    this.isAdmin = isAdmin;
    notifyListeners();
  }

  void setIsAuth(bool isAuth){
    this.isAuth = isAuth;
    notifyListeners();
  }
}