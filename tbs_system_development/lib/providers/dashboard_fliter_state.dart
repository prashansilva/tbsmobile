import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tbssystemdevelopment/models/document_model.dart';
import 'package:tbssystemdevelopment/models/form/discussion_form_model.dart';
import 'package:tbssystemdevelopment/models/response_model.dart';
import 'package:tbssystemdevelopment/services/api_manager.dart';
import 'package:tbssystemdevelopment/services/local_storage.dart';
import 'package:tbssystemdevelopment/utils/constants.dart';

import '../locator.dart';

class DashboardFilterState extends ChangeNotifier {
  String url = 'Dashboard/';
  String documentType = 'Disscussion';
  late bool loading;
  int count = 0;
  int totalCount = 0;
  List<DiscussionFormData> documentList = [];
  ApiManager _apiManager = locator<ApiManager>();
  LocalStorage localStorage = locator<LocalStorage>();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  Map toMapGetDocumentList(String id, String roleCode, int count) {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["role_code"] = roleCode;
    map["count"] = count;
    map["document_type"] = documentType;
    map["start_date"] = '${this.startDate.year}-${this.startDate.month}-${this.startDate.day}';
    map["end_date"] = '${this.endDate.year}-${this.endDate.month}-${this.endDate.day}';
    return map;
  }

  void resetDataTotal() {
    this.count = 0;
    this.documentList = [];
    this.startDate = DateTime.parse('1990-01-01');
    this.endDate = DateTime.now();
  }

  void resetDataDaily() {
    this.count = 0;
    this.documentList = [];
    this.startDate =  DateTime.now();
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
    this.documentList = [];
  }

  Future<List<DiscussionFormData>?> getDiscussionDocumentList() async {
    var loggedUser = await localStorage.getUserData();
    if(loggedUser != null) {
      var dataMapper = toMapGetDocumentList(loggedUser.id,loggedUser.role_code,count);
      var body = utf8.encode(jsonEncode(dataMapper));
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': '*/*',
      };

      try {
        this.loading = true;
        final response =
        await _apiManager.post(url + 'document_data', body, requestHeaders);
        List<DiscussionFormData> newDocumentList = [];
        if (response["data"] != null) {
          var list = (response['data']) as List;
          newDocumentList =
              list.map((data) => DiscussionFormData.fromJson(data)).toList();
          documentList.addAll(newDocumentList);
        }
        this.count = this.count + newDocumentList.length;
        this.totalCount = response["count"] != null ? response["count"] : 0;
        this.loading = false;
        notifyListeners();
        return newDocumentList;
      } catch (err) {
        print(err);
        this.loading = false;
        return this.documentList;
      }
    }
    else {
      return this.documentList;
    }

  }
}
