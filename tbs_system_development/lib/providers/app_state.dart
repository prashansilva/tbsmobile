import 'package:flutter/material.dart';
import 'package:tbssystemdevelopment/services/local_storage.dart';

import '../locator.dart';

class AppState extends ChangeNotifier {
  bool isLoading = false;
  bool isLoggedIn = false;
  LocalStorage localStorage = locator<LocalStorage>();

  void setLoading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  void checkIfLoggedIn() async {
    setLoading(true);
    this.isLoggedIn = false;
    setLoading(false);
  }

  Future<bool> checkAuth() async {
    var value = await localStorage.isLogged();
    if (value == null) {
      return false;
    }
    return value;
  }
}
