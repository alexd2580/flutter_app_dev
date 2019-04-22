import 'package:mobx/mobx.dart';

import '../utils/RequestStatus.dart';

import 'Producer.dart';

part 'ProducerList.g.dart';

class ProducerList = _ProducerList with _$ProducerList;

abstract class _ProducerList implements Store {
  @observable
  RequestStatus searchRequestStatus = RequestStatus.waiting;

  @observable
  String searchError;

  @observable
  ObservableMap<int, Producer> producers = ObservableMap();

  @action
  void clear() => producers.clear();
}
