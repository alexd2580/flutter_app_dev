import 'dart:convert';

import 'package:http/http.dart' as http;

String encodeParam(MapEntry<String, dynamic> entry) =>
    "${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value)}";

String encodeParams(Map<String, dynamic> params) =>
    params.entries.map(encodeParam).join("&");

Future<http.Response> httpGet(baseUrl,
    [String path, Map<String, dynamic> params]) async {
  var url = baseUrl;
  if (path != null) {
    url = "$url/$path";
  }
  if (params != null) {
    final encodedParams = encodeParams(params);
    url = "$url?$encodedParams";
  }
  return await http.get(url);
}

Future<String> httpGetSuccess(baseUrl,
    [String path, Map<String, dynamic> params]) async {
  final response = await httpGet(baseUrl, path, params);
  if (response.statusCode != 200) {
    throw Exception();
  }
  return response.body;
}

Future<Map> httpGetJson(baseUrl,
        [String path, Map<String, dynamic> params]) async =>
    jsonDecode(await httpGetSuccess(baseUrl, path, params));
