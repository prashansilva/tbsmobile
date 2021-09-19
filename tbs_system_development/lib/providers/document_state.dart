import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tbssystemdevelopment/models/document_model.dart';
import 'package:tbssystemdevelopment/models/form/discussion_form_model.dart';
import 'package:tbssystemdevelopment/models/response_model.dart';
import 'package:tbssystemdevelopment/services/api_manager.dart';
import 'package:tbssystemdevelopment/services/local_storage.dart';
import 'package:tbssystemdevelopment/utils/constants.dart';

import '../locator.dart';

class DocumentState extends ChangeNotifier {
  String url = 'Document/';
  bool isCoordinator = false;
  late DocumentData document;
  late bool loading;
  int count = 0;
  int myPersonalCount = 0;
  late String coordinatorId;
  List<DocumentData> documentList = [];
  List<DiscussionFormData> discussionDocumentList = [];
  ApiManager _apiManager = locator<ApiManager>();
  LocalStorage localStorage = locator<LocalStorage>();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  Map toMapGetDocument(int id) {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    return map;
  }

  Map toMapCreateDiscussionDocument(
      String managerId,
      String lineLeaderId,
      String coordinatorId,
      String discusser,
      String prospector,
      String mobileNumber) {
    var map = new Map<String, dynamic>();
    map["manager_id"] = managerId;
    map["line_leader_id"] = lineLeaderId;
    map["coordinator_id"] = coordinatorId;
    map["discusser"] = discusser;
    map["prospector"] = prospector;
    map["mobile_number"] = mobileNumber;
    return map;
  }

  Future<bool> getDocument(int id) async {
    var loggedUser = await localStorage.getUserData();
    var dataMapper = toMapGetDocument(id);
    var body = utf8.encode(jsonEncode(dataMapper));
    print(dataMapper);
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': '*/*',
      'Authorization': loggedUser == null ? '' : loggedUser.id,
    };

    try {
      print(body);
      final response =
          await _apiManager.post(url + 'document', body, requestHeaders);
      if (response["data"] != null) {
        document = DocumentData.fromJson(response["data"]);
        notifyListeners();
        return true;
      }
      return false;
    } catch (err) {
      return false;
    }
  }

  void resetData(String id, bool isCoordinator) {
    this.count = 0;
    this.discussionDocumentList = [];
    this.documentList = [];
    this.coordinatorId = id;
    this.isCoordinator = isCoordinator;
    this.startDate = DateTime.now();
    this.endDate = DateTime.now();
  }

  void setStartDate(DateTime date) {
    this.startDate = date;
    notifyListeners();
  }

  void setEndDate(DateTime date) {
    this.endDate = date;
    notifyListeners();
  }


  void resetFilterDetails(DateTime startDate, DateTime endDate) {
    this.startDate = startDate;
    this.endDate = endDate;
    this.count = 0;
    this.discussionDocumentList = [];
  }

  Future<List<DocumentData>?> getDocumentList() async {
    var loggedUser = await localStorage.getUserData();
    var body = utf8.encode(jsonEncode({'start': count}));
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': '*/*',
      'Authorization': loggedUser == null ? '' : loggedUser.id,
    };

    try {
      this.loading = true;
      final response =
          await _apiManager.post(url + 'documents', body, requestHeaders);
      List<DocumentData> newDocumentList = [];
      if (response["data"] != null) {
        var list = (response['data']) as List;
        newDocumentList =
            list.map((data) => DocumentData.fromJson(data)).toList();
        documentList.addAll(newDocumentList);
      }
      this.count = this.count + newDocumentList.length;
      this.loading = false;
      notifyListeners();
      return newDocumentList;
    } catch (err) {
      this.loading = false;
      print(err);
    }
  }



  Future<ResponseData> createDiscussionForm(
      String discusser, String prospector, String mobileNumber) async {
    var loggedUser = await localStorage.getUserData();
    if (loggedUser != null) {
      late Map dataMapper;
      if(loggedUser.role_code == "1") {
            dataMapper = toMapCreateDiscussionDocument(
            loggedUser.id,
            "",
            "",
            discusser,
            prospector,
            mobileNumber);
      }
      else if (loggedUser.role_code == "2") {
            dataMapper = toMapCreateDiscussionDocument(
            loggedUser.manager_id,
            loggedUser.id,
            "",
            discusser,
            prospector,
            mobileNumber);
      }
      else {
            dataMapper = toMapCreateDiscussionDocument(
            loggedUser.manager_id,
            loggedUser.line_leader_id,
            loggedUser.id,
            discusser,
            prospector,
            mobileNumber);
      }
      var body = utf8.encode(jsonEncode(dataMapper));
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': '*/*',
      };

      try {
        final response = await _apiManager.post(
            url + 'discussion_form_create', body, requestHeaders);
        ResponseData responseData = new ResponseData(
            message: response["message"], status: response["status"]);
        return responseData;
      } catch (err) {
        print(err);
        ResponseData responseData =
            new ResponseData(message: 'Something went wrong', status: false);
        return responseData;
      }
    } else {
      ResponseData responseData =
          new ResponseData(message: 'Something went wrong', status: false);
      return responseData;
    }
  }

  Map toMapGetDiscussionDocument(String id , int count) {
    var map = new Map<String, dynamic>();
    map["coordinator_id"] = id;
    map["start"] = count;
    map["start_date"] = '${this.startDate.year}-${this.startDate.month}-${this.startDate.day}';
    map["end_date"] = '${this.endDate.year}-${this.endDate.month}-${this.endDate.day}';
    return map;
  }

  Future<List<DiscussionFormData>?> getDiscussionDocumentList() async {
    var dataMapper = toMapGetDiscussionDocument(coordinatorId,count);
    var body = utf8.encode(jsonEncode(dataMapper));
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': '*/*',
    };

    try {
      this.loading = true;
      final response =
      await _apiManager.post(url + 'discussion_form_list', body, requestHeaders);
      List<DiscussionFormData> newDocumentList = [];
      if (response["data"] != null) {
        var list = (response['data']) as List;
        newDocumentList =
            list.map((data) => DiscussionFormData.fromJson(data)).toList();
        discussionDocumentList.addAll(newDocumentList);
      }
      this.count = this.count + newDocumentList.length;
      this.loading = false;
      notifyListeners();
      return newDocumentList;
    } catch (err) {
      print(err);
      this.loading = false;
      return this.discussionDocumentList;
    }
  }

  // new methods

  Map toMapGetMyPersonal(String id, String role_code) {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["role_code"] = role_code;
    map["count"] = this.count;
    map["start_date"] = '${this.startDate.year}-${this.startDate.month}-${this.startDate.day}';
    map["end_date"] = '${this.endDate.year}-${this.endDate.month}-${this.endDate.day}';
    return map;
  }


  Future<List<DiscussionFormData>?> getMyPersonal() async {
    var loggedUser = await localStorage.getUserData();
    if(loggedUser != null) {
      var dataMapper = toMapGetMyPersonal(loggedUser.id,loggedUser.role_code);
      var body = utf8.encode(jsonEncode(dataMapper));
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': '*/*',
      };

      try {
        this.loading = true;
        final response =
        await _apiManager.post(url + 'getMyPersonal', body, requestHeaders);
        List<DiscussionFormData> newDocumentList = [];
        if (response["data"] != null) {
          var list = (response['data']["documents"]) as List;
          newDocumentList =
              list.map((data) => DiscussionFormData.fromJson(data)).toList();
          discussionDocumentList.addAll(newDocumentList);
        }
        this.count = this.count + newDocumentList.length;
        this.myPersonalCount = response["data"]["totalCount"];
        this.loading = false;
        notifyListeners();
        return newDocumentList;
      } catch (err) {
        print(err);
        this.loading = false;
        return this.discussionDocumentList;
      }
    }
    else {

    }
  }
}
