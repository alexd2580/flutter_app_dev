import 'package:flutter/material.dart';

List<B> mapWithIndex<A, B>(List<A> list, B f(A, int)) {
  List<B> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(f(list[i], i));
  }
  return result;
}

A attempt<A>(A function(), [A defaultValue]) {
  try {
    return function();
  } catch (something) {
    return defaultValue;
  }
}

Map<V, K> reverseMap<K, V>(Map<K, V> data) =>
    data.map((key, value) => MapEntry(value, key));

typedef Parser<T> = T Function(String);
Parser<V> parseWithMessage<V>(Map<String, V> container, String description) =>
    (String stringRepr) =>
        container[stringRepr] ??
        (() {
          print("Unknown $description: $stringRepr");
          return null;
        })();

typedef Printer<T> = String Function(T);
Printer<V> printWithDefault<V>(
        Map<V, String> container, String defaultString) =>
    (V value) => container[value] ?? defaultString;

Expanded expand(Widget child) => Expanded(child: child);

typedef Func0<R> = R Function();
typedef Func1<P1, R> = R Function(P1);
typedef Func2<P1, P2, R> = R Function (P1, P2);
