import 'package:mobx/mobx.dart';

import '../utils/overpass.dart';
import '../utils/RequestStatus.dart';

part 'MoscowStations.g.dart';

class MoscowStations = _MoscowStations with _$MoscowStations;

abstract class _MoscowStations with Overpass implements Store {
  @observable
  RequestStatus elementsRequestStatus = RequestStatus.waiting;

  @observable
  String loadingError = "";

  @observable
  ObservableList<Map<String, dynamic>> elements;

  final GeoBB location = GeoBB(GeoLocation(55.381451059152, 36.922302246094),
      GeoLocation(56.056702371098, 38.371124267578));

  @action
  void clear() {
    elements.clear();
    elementsRequestStatus = RequestStatus.waiting;
  }

  Future<ObservableList<Map<String, dynamic>>> queryStationsAsync() async {
    final results = await Overpass.search("railway", "station", location);
    return ObservableList<dynamic>.of(results["elements"]).cast<Map<String, dynamic>>();
  }

  @action
  void queryStations() {
    elementsRequestStatus = RequestStatus.inProgress;
    queryStationsAsync().then((result) {
      elements = result;
      elementsRequestStatus = RequestStatus.success;
    }).catchError((error) {
      loadingError = error.toString();
      elementsRequestStatus = RequestStatus.failure;
    });
  }
}
