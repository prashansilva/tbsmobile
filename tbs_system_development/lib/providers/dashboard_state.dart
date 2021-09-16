import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tbssystemdevelopment/models/dashboard_model.dart';
import 'package:tbssystemdevelopment/models/dashboard_user_model.dart';
import 'package:tbssystemdevelopment/models/response_model.dart';
import 'package:tbssystemdevelopment/models/user_model.dart';
import 'package:tbssystemdevelopment/services/api_manager.dart';
import 'package:tbssystemdevelopment/services/local_storage.dart';

import '../locator.dart';

class DashboardState extends ChangeNotifier {
  String url = 'Dashboard/';
  late DashboardData dashboard;
  bool loading = false;
  bool isManager = false;
  List<DashboardMemberData> leadersList = [];
  List<DashboardMemberData> coordinatorList = [];
  List<UserData> leaderListByManager = [];
  List<UserData> coordinatorListByManager = [];
  ApiManager _apiManager = locator<ApiManager>();
  LocalStorage localStorage = locator<LocalStorage>();

  void resetLeaders() {
    this.leadersList = [];
  }

  void resetCoordinators() {
    this.coordinatorList = [];
  }

  void resetLeadersScreen() {
    this.leaderListByManager = [];
  }

  void resetCoordinatorsScreen() {
    this.coordinatorListByManager = [];
  }

  Map toMap(String id, String roleCode) {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["role_code"] = roleCode;
    map["create_date"] = '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
    return map;
  }

  Map toMapGetMembers(String id) {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["date"] = '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
    return map;
  }

  Future<DashboardData> getDashboardData() async {
    var loggedUser = await localStorage.getUserData();
    if(loggedUser != null) {
      var dataMapper = toMap(loggedUser.id, loggedUser.role_code);
      var body = utf8.encode(jsonEncode(dataMapper));
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': '*/*',
      };

      try {
        print(body);
        final response =
        await _apiManager.post(url + 'data', body, requestHeaders);
        notifyListeners();
        if (response["data"] != null) {
          this.dashboard = DashboardData.fromJson(response['data']);
        }
        return dashboard;
      } catch (err) {
        print(err);
        DashboardData responseData =
        new DashboardData(totalCount: 0, todayCount: 0, leadersCount: 0, coordinatorsCount: 0, documents: []);
        return responseData;
      }
    }
    else {
      DashboardData responseData =
      new DashboardData(totalCount: 0, todayCount: 0, leadersCount: 0, coordinatorsCount: 0, documents: []);
      return responseData;
    }
  }

  Future<List<DashboardMemberData>> getLeadersList(String id) async {
    var dataMapper = toMapGetMembers(id);
    var body = utf8.encode(jsonEncode(dataMapper));
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': '*/*',
    };

    try {
      print(body);
      this.loading = true;
      final response =
      await _apiManager.post(url + 'manager', body, requestHeaders);
      notifyListeners();
      if (response["data"] != null) {
        var list = (response['data']) as List;
        this.leadersList = list.map((data) => DashboardMemberData.fromJson(data)).toList();
      }
      this.loading = false;
      return leadersList;
    } catch (err) {
      print(err);
      this.loading = false;
      return leadersList;
    }
  }

  Future<List<DashboardMemberData>> getCoordinatorsList(String id) async {
    var dataMapper = toMapGetMembers(id);
    var body = utf8.encode(jsonEncode(dataMapper));
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': '*/*',
    };

    try {
      print(body);
      this.loading = true;
      final response =
      await _apiManager.post(url + 'leader', body, requestHeaders);
      notifyListeners();
      if (response["data"] != null) {
        var list = (response['data']) as List;
        this.coordinatorList = list.map((data) => DashboardMemberData.fromJson(data)).toList();
      }
      this.loading = false;
      return coordinatorList;
    } catch (err) {
      print(err);
      this.loading = false;
      return coordinatorList;
    }
  }

  Future<List<UserData>> getLeadersByManger() async {
    var loggedUser = await localStorage.getUserData();
    if (loggedUser != null && loggedUser.role_code == "1") {
      var dataMapper = toMapGetMembers(loggedUser.id);
      var body = utf8.encode(jsonEncode(dataMapper));
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': '*/*',
      };

      try {
        this.loading = true;
        final response =
        await _apiManager.post(url + 'leadersByManager', body, requestHeaders);
        notifyListeners();
        if (response["data"] != null) {
          var list = (response['data']) as List;
          this.leaderListByManager = list.map((data) => UserData.fromJson(data)).toList();
        }
        this.isManager = true;
        this.loading = false;
        return leaderListByManager;
      } catch (err) {
        print(err);
        this.loading = false;
        return leaderListByManager;
      }
    }else {
      return leaderListByManager;
    }

  }

  Future<List<UserData>> getCoordinatorsByManger() async {
    var loggedUser = await localStorage.getUserData();
    if (loggedUser != null && loggedUser.role_code == "1") {
      var dataMapper = toMapGetMembers(loggedUser.id);
      var body = utf8.encode(jsonEncode(dataMapper));
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': '*/*',
      };
      print(loggedUser.role_code);
      try {
        this.loading = true;
        final response =
        await _apiManager.post(url + 'coordinatorsByManager', body, requestHeaders);
        notifyListeners();
        if (response["data"] != null) {
          var list = (response['data']) as List;
          this.coordinatorListByManager = list.map((data) => UserData.fromJson(data)).toList();
        }
        this.isManager = true;
        this.loading = false;
        return coordinatorListByManager;
      } catch (err) {
        print(err);
        this.loading = false;
        return coordinatorListByManager;
      }
    }else {
      return coordinatorListByManager;
    }

  }

  Future<List<UserData>> getCoordinatorsByLeader() async {
    var loggedUser = await localStorage.getUserData();
    if (loggedUser != null && loggedUser.role_code == "2") {
      var dataMapper = toMapGetMembers(loggedUser.id);
      var body = utf8.encode(jsonEncode(dataMapper));
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': '*/*',
      };

      try {
        this.loading = true;
        final response =
        await _apiManager.post(url + 'coordinatorsByLeader', body, requestHeaders);
        notifyListeners();
        if (response["data"] != null) {
          var list = (response['data']) as List;
          this.coordinatorListByManager = list.map((data) => UserData.fromJson(data)).toList();
        }
        this.isManager = false;
        this.loading = false;
        return coordinatorListByManager;
      } catch (err) {
        print(err);
        this.loading = false;
        return coordinatorListByManager;
      }
    }else {
      return coordinatorListByManager;
    }

  }

  Map toUpgradeCoordinatorByManger(String id) {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    return map;
  }

  Future<ResponseData> upgradeCoordinatorByManger(String id) async {
    var loggedUser = await localStorage.getUserData();
    if (loggedUser != null && loggedUser.role_code == "1") {
      var dataMapper = toUpgradeCoordinatorByManger(id);
      var body = utf8.encode(jsonEncode(dataMapper));
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': '*/*',
      };

      try {
        this.loading = true;
        final response =
        await _apiManager.post(url + 'updateCoordinatorByManager', body, requestHeaders);
        notifyListeners();
        if (response["data"] != null) {
          var list = (response['data']) as List;
          this.coordinatorListByManager = list.map((data) => UserData.fromJson(data)).toList();
        }
        this.loading = false;
        ResponseData responseData = new ResponseData(message: response["message"], status: response["status"]);
        return responseData;
      } catch (err) {
        print(err);
        this.loading = false;
        ResponseData responseData = new ResponseData(message: 'Something went wrong', status: false);
        return responseData;
      }
    }else {
      ResponseData responseData = new ResponseData(message: 'Something went wrong', status: false);
      return responseData;
    }

  }

  Map toMapRegisterLeader(UserData userData, String manager_id) {
    var map = new Map<String, dynamic>();
    map["code"] = userData.code;
    map["first_name"] = userData.first_name;
    map["last_name"] = userData.last_name;
    map["location"] = userData.location;
    map["mobile_number"] = userData.mobile_number;
    map["manager_id"] = manager_id;
    return map;
  }

  Future<ResponseData> userRegisterLeader(UserData user) async {
    var loggedUser = await localStorage.getUserData();
    if (loggedUser != null && loggedUser.role_code == "1") {
      var dataMapper = toMapRegisterLeader(user, loggedUser.id);
      var body = utf8.encode(jsonEncode(dataMapper));
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': '*/*',
      };

      try {
        final response =
        await _apiManager.post(url + 'addLeaderByManager', body, requestHeaders);
        ResponseData responseData = new ResponseData(message: response["message"], status: response["status"]);
        return responseData;
      } catch (err) {
        ResponseData responseData = new ResponseData(message: 'Something went wrong', status: false);
        return responseData;
      }
    }else {
      ResponseData responseData = new ResponseData(message: 'Something went wrong', status: false);
      return responseData;
    }

  }

}
