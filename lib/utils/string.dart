import 'dart:convert';
// import 'dart:mirrors';

String utf8Decode(String mangled) => utf8.decode(mangled.codeUnits);

String toPrettyString(dynamic obj) =>
    utf8Decode(JsonEncoder.withIndent('  ').convert(obj));

void prettyPrint(dynamic obj) => print(toPrettyString(obj));

// void printTypeName(dynamic obj) =>
//    print(reflect(obj).type.reflectedType.toString());
