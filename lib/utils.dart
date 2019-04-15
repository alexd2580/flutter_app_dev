import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'dart:mirrors';
import 'package:flutter/material.dart';

String encodeParam(MapEntry<String, dynamic> entry) =>
    "${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value)}";

String encodeParams(Map<String, dynamic> params) =>
    params.entries.map(encodeParam).join("&");

String utf8Decode(String mangled) => utf8.decode(mangled.codeUnits);

String toPrettyString(dynamic obj) =>
    utf8Decode(JsonEncoder.withIndent('  ').convert(obj));

void prettyPrint(dynamic obj) => print(toPrettyString(obj));

// void printTypeName(dynamic obj) =>
//    print(reflect(obj).type.reflectedType.toString());

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

enum RequestStatus { waiting, inProgress, success, failure }

class RequestStatusIndicator extends StatelessWidget {
  final RequestStatus _status;

  RequestStatusIndicator(this._status);

  Widget build(BuildContext context) {
    switch (_status) {
      case RequestStatus.waiting:
        return Text("Waiting...");
      case RequestStatus.inProgress:
        return Text("Loading");
      case RequestStatus.failure:
        return Text("Error!");
      case RequestStatus.success:
        return Text("Success.");
    }
    return null;
  }
}

List<B> mapWithIndex<A, B>(List<A> list, B f(A, int)) {
  List<B> result = [];
  for (var i=0; i< list.length; i++) {
    result.add(f(list[i], i));
}
  return result;
}