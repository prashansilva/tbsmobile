import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tbssystemdevelopment/models/response_model.dart';
import 'package:tbssystemdevelopment/models/user_model.dart';
import 'package:tbssystemdevelopment/services/api_manager.dart';
import 'package:tbssystemdevelopment/services/local_storage.dart';
import 'package:tbssystemdevelopment/utils/constants.dart';

import '../locator.dart';

class UserState extends ChangeNotifier {
  String url = 'Authentication/';
  late UserData userData;
  ApiManager _apiManager = locator<ApiManager>();
  LocalStorage localStorage = locator<LocalStorage>();

  Map toMap(String user_code, String password) {
    var map = new Map<String, dynamic>();
    map["user_code"] = user_code;
    map["password"] = password;
    return map;
  }

  Map toMapRegister(UserData userData, String password) {
    var map = new Map<String, dynamic>();
    map["code"] = userData.code;
    map["password"] = password;
    map["first_name"] = userData.first_name;
    map["last_name"] = userData.last_name;
    map["location"] = userData.location;
    map["mobile_number"] = userData.mobile_number;
    map["manager_id"] = userData.manager_id;
    map["line_leader_id"] = userData.line_leader_id;
//    map["user_code"] = 'PL123';
//    map["password"] = '123456';
//    map["first_name"] = 'Prashan';
//    map["last_name"] = 'Silva';
//    map["location"] = 'Panadura';
//    map["mobile_number"] = '0714148103';
//    map["manager_id"] = '1';
//    map["line_leader_id"] = '2';
    return map;
  }

  Future<ResponseData> userLogin(String user_code, String password) async {
    var dataMapper = toMap(user_code, password);
    var body = utf8.encode(jsonEncode(dataMapper));
    print(dataMapper);
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': '*/*',
    };

    try {
      print(body);
      final response = await _apiManager.post(url+'login', body, requestHeaders);
      print(response);
      if(response["auth"] == true) {
        userData = UserData.fromJson(response["data"][0]);
        String storeData = json.encode(userData);
        localStorage.setUserData(USER_DATA, storeData);
        localStorage.setLoggin(true);
        notifyListeners();
      }
      ResponseData responseData = new ResponseData(message: response["message"], status: response["auth"]);
      return responseData;
    } catch (err) {
      print(err);
      ResponseData responseData = new ResponseData(message: 'Something went wrong', status: false);
      return responseData;
    }
  }

  Future<ResponseData> userRegister(UserData userData, String password) async {
    var dataMapper = toMapRegister(userData, password);
    var body = utf8.encode(jsonEncode(dataMapper));
    print(dataMapper);
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': '*/*',
    };

    try {
      print(body);
      final response = await _apiManager.post('User/register', body, requestHeaders);
      ResponseData responseData = new ResponseData(message: response["message"], status: response["status"]);
      return responseData;
    } catch (err) {
      print(err);
      ResponseData responseData = new ResponseData(message: 'Something went wrong', status: false);
      return responseData;
    }
  }

  Future<ResponseData> userCodeValidate(String userCode) async {
    var body = utf8.encode(jsonEncode({'userCode' : userCode}));
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': '*/*',
    };

    try {
      print(body);
      final response = await _apiManager.post('User/forgetpassword', body, requestHeaders);
      if(response["status"]) {
        localStorage.setUserCode(userCode);
      }
      ResponseData responseData = new ResponseData(message: response["message"], status: response["status"]);
      return responseData;
    } catch (err) {
      print(err);
      ResponseData responseData = new ResponseData(message: 'Something went wrong', status: false);
      return responseData;
    }
  }

  Map toMapOtpValidate(String? userCode, String opt) {
    var map = new Map<String, dynamic>();
    map["userCode"] = userCode.toString();
    map["code"] = opt.toString();
    return map;
  }

  Future<ResponseData> otpValidate(String opt) async {
    var userCode = await localStorage.getUserCode();
    print(userCode);
    print(opt);
    var dataMapper = toMapOtpValidate(userCode, opt);
    var body = utf8.encode(jsonEncode(dataMapper));
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': '*/*',
    };

    try {
      final response = await _apiManager.post('User/validateotp', body, requestHeaders);
      ResponseData responseData = new ResponseData(message: response["message"], status: response["status"]);
      return responseData;
    } catch (err) {
      ResponseData responseData = new ResponseData(message: 'Something went wrong', status: false);
      return responseData;
    }
  }

  Future<ResponseData> passwordReset(String password) async {
    var userCode = await localStorage.getUserCode();
    var body = utf8.encode(jsonEncode({'userCode' : userCode, 'password': password}));
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': '*/*',
    };

    try {
      print(body);
      final response = await _apiManager.post('User/changepassword', body, requestHeaders);
      ResponseData responseData = new ResponseData(message: response["message"], status: response["status"]);
      return responseData;
    } catch (err) {
      print(err);
      ResponseData responseData = new ResponseData(message: 'Something went wrong', status: false);
      return responseData;
    }
  }

  Future<void> userLogOut() async {
    localStorage.removeLoggedUser();
    localStorage.setLoggin(false);
    notifyListeners();
  }

  Future<bool> checkAuth() async {
    var value = await localStorage.isLogged();
    if (value == null) {
      return false;
    }
    return value;
  }
}
