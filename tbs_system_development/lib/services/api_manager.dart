import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'app_exception.dart';

class ApiManager {
  final _baseUrl = 'http://tbssystem.uzonix.com/tbs/index.php/api/';
//  final _baseUrl = 'http://192.168.1.3/tbs/index.php/api/';

// GET METHOD
  Future<dynamic> get(String url, Map<String, String> requestHeaders) async {
    var responseJson;
    var apiUrl = Uri.parse(_baseUrl + url);
    try {
      final response = await http.get(apiUrl, headers: requestHeaders);
      responseJson = returnResponse(response);
    } on TimeoutException {
      return Future.error('Server timeout');
    } on SocketException {
      return Future.error('No Internet Connection');
    }
    return responseJson;
  }

  // POST METHOD
  Future<dynamic> post(String url, dynamic body, Map<String, String> requestHeaders) async {
    var responseJson;
    var apiUrl = Uri.parse(_baseUrl + url);
    print(apiUrl);
    try {
      final response = await http
          .post(apiUrl, body: body, headers: requestHeaders)
          .timeout(const Duration(seconds: 60));
      responseJson = returnResponse(response);
    } on TimeoutException {
      print('timeout');
      return Future.error('Server timeout');
    } on SocketException {
      print('socket');
      return Future.error('No Internet Connection');
    }  catch (err) {
      print(err);
    }

    return responseJson;
  }

// PUT METHOD
  Future<dynamic> put(String url, dynamic body) async {
    var responseJson;
    var apiUrl = Uri.parse(_baseUrl + url);
    try {
      final response = await http.put(apiUrl, body: body);
      responseJson = returnResponse(response);
    } on TimeoutException {
      return Future.error('Server timeout');
    } on SocketException {
      return Future.error('No Internet Connection');
    }
    return responseJson;
  }

// DELETE METHOD
  Future<dynamic> delete(String url) async {
    var apiResponse;
    var apiUrl = Uri.parse(_baseUrl + url);
    try {
      final response = await http.delete(apiUrl);
      apiResponse = returnResponse(response);
    } on TimeoutException {
      return Future.error('Server timeout');
    } on SocketException {
      return Future.error('No Internet Connection');
    }
    return apiResponse;
  }
}

dynamic returnResponse(response) {
  print(response.body);
  switch (response.statusCode) {
    case 200:
      var responseJson = jsonDecode(response.body.toString());
      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
