import 'dart:convert';
import 'package:tbssystemdevelopment/models/user_model.dart';
import 'package:tbssystemdevelopment/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {

  void setUserData(
      String key,
      String data,
      ) async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    sharedPreferences.setString(key, data);
  }

  Future<UserData?> getUserData() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    late String? userData = sharedPreferences.getString(USER_DATA);
    if(userData == null) {
      return null;
    }
    else {
      UserData data =
      UserData.fromJson(jsonDecode(userData));
      return data;
    }
  }

  Future<bool> checkIfKeyExist(key) async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    return sharedPreferences.containsKey(key);
  }

  Future<bool?> isLogged() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    return sharedPreferences.containsKey(USER_DATA);
  }

  Future<String?> getToken() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    return sharedPreferences.getString(Token);
  }

  void setLoggin(bool value) async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    sharedPreferences.setBool(IS_LOGGED, value);
  }

  void setToken(String token) async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    sharedPreferences.setString(Token, token);
  }

  void setUserCode(String usercode) async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    sharedPreferences.setString('UC', usercode);
  }

  Future<String?> getUserCode() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    return sharedPreferences.getString('UC');
  }

  void removeLoggedUser() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    sharedPreferences.remove(USER_DATA);
    sharedPreferences.setBool(IS_LOGGED, false);
  }
}
