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
