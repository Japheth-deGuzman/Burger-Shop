import 'dart:convert';

import 'package:favorite/models/models.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class Methods {
  final String baseUrl = 'https://6390004f7642fef654d414a3.mockapi.io/';
  var client = Client();
  Map<String, String> headers = {'Content-Type': 'application/json'};
  Future<List<Food?>> get(String api) async {
    var url = Uri.parse(baseUrl + api);
    var response = await client.get(url);
    debugPrint('Get Status: ${response.statusCode.toString()}');
    if (response.statusCode == 200) {
      var json = response.body;
      return foodFromJson(json);
    } else {
      debugPrint('someting went wrong ${response.statusCode}');
    }
    return [];
  }

  Future<List<Food?>> getalllikes(String api) async {
    var url = Uri.parse(baseUrl + api);
    var response = await client.get(url);

    if (response.statusCode == 200) {
      var json = response.body;
      return foodFromJson(json);
    } else {
      debugPrint('someting went wrong ${response.statusCode}');
    }
    return [];
  }

  Future<dynamic> posttolikes(String api, Food object) async {
    var url = Uri.parse(baseUrl + api);

    var payload = jsonEncode(object);

    var response = await client.post(url, headers: headers, body: payload);
    if (response.statusCode == 201) {
    } else {
      debugPrint('someting went wrong ${response.statusCode}');
    }
  }
}
