List<B> mapWithIndex<A, B>(List<A> list, B f(A, int)) {
  List<B> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(f(list[i], i));
  }
  return result;
}
