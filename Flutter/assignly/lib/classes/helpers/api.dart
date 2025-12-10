import 'package:assignly/classes/objects/path.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class API {
  static const String _url = 'assignlydbapi.mikkeldamgaard.dk/api/';

  // TODO: USE TEST
  static const String _testUrl = 'assignlydbapi.mikkeldamgaard.dk/api/';



  // Post Request
  static Future<http.Response> postRequest(String envelope, ApiPath action) async {
    // Create header with action
    final header = {
      'Content-Type': 'text/xml;charset=UTF-8',
      'Content-Length': '${envelope.length}',
      'Accept': 'text/plain',
    };

    // Post the request
    var temp = http.post(
      Uri.parse((!kReleaseMode ? _url : _testUrl) + action.value),
      headers: header,
      body: utf8.encode(envelope),
    );
    return temp;
  }

  // Get Request
  static Future<http.Response> getRequest(ApiPath action) async {
    // Create header with action
    final header = {
      'Content-Type': 'application/json; charset=utf-8',
      'Connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br',
      'Accept': 'text/plain',
    };

    var a = Uri.parse((!kReleaseMode ? _url : _testUrl) + action.value);

    // Get Request
    var temp = await http.get(
      Uri.parse((!kReleaseMode ? _url : _testUrl) + action.value),
      headers: header,
    );
    return temp;
  }
}
