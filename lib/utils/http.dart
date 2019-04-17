import 'dart:convert';

import 'package:http/http.dart' as http;

String encodeParam(MapEntry<String, dynamic> entry) =>
    "${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value)}";

String encodeParams(Map<String, dynamic> params) =>
    params.entries.map(encodeParam).join("&");

Future<http.Response> httpGet(baseUrl, [Map<String, dynamic> params]) async {
  var url;
  if (params != null) {
    final encodedParams = encodeParams(params);
    url = "$baseUrl?$encodedParams";
  } else {
    url = baseUrl;
  }
  return await http.get(url);
}

Future<String> httpGetSuccess(baseUrl, [Map<String, dynamic> params]) async {
  final response = await httpGet(baseUrl, params);
  if (response.statusCode != 200) {
    throw Exception();
  }
  return response.body;
}

Future<Map> httpGetJson(baseUrl, [Map<String, dynamic> params]) async =>
    jsonDecode(await httpGetSuccess(baseUrl, params));
