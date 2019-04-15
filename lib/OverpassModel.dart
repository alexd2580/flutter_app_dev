import 'utils.dart';
import 'dart:collection';
import 'package:scoped_model/scoped_model.dart';

class GeoLocation {
  double latitude, longitude;
  GeoLocation(this.latitude, this.longitude);
}

class GeoBB {
  GeoLocation min, max;
  GeoBB(this.min, this.max);
}

mixin Overpass {
  static const url = "https://lz4.overpass-api.de/api/interpreter";

  static Future<Map<String, dynamic>> search(
      String key, String value, GeoBB bb) async {
    final loc =
        "${bb.min.latitude}, ${bb.min.longitude}, ${bb.max.latitude}, ${bb.max.longitude}";
    final overpassQlRequest = """
        [out:json][timeout:25];
        node["$key"="$value"]($loc);
        out; >; out skel qt;
    """;
    final params = {"data": overpassQlRequest};
    return (await httpGetJson(url, params)) as Map<String, dynamic>;
  }
}

class MoscowStationsModel extends Model with Overpass {
  RequestStatus _elementsRequestStatus = RequestStatus.waiting;
  List<Map<String, dynamic>> _elements;

  GeoBB location = GeoBB(GeoLocation(55.381451059152, 36.922302246094),
      GeoLocation(56.056702371098, 38.371124267578));

  RequestStatus get elementsRequestStatus => _elementsRequestStatus;
  UnmodifiableListView<Map<String, dynamic>> get elements =>
      UnmodifiableListView(_elements);

  void clear() {
    _elements.clear();
    _elementsRequestStatus = RequestStatus.waiting;
    notifyListeners();
  }

  Future<void> queryStations() async {
    _elementsRequestStatus = RequestStatus.inProgress;
    notifyListeners();
    try {
      final results = await Overpass.search("railway", "station", location);
      _elements = results["elements"].cast<Map<String, dynamic>>();
      _elementsRequestStatus = RequestStatus.success;
    } catch (e) {
      print(e);
      _elementsRequestStatus = RequestStatus.failure;
    }
    notifyListeners();
  }
}

// Map<String, dynamic> getTags(Map<String, dynamic> map) => map["tags"];
// List<String> getKeys(Map<String, dynamic> map) => map.keys.toList();

//    final tagDicts = elements.map(getTags).cast<Map<String, dynamic>>();
//    final keySet = tagDicts.expand(getKeys);
//
//    final fieldValues = Map<String, List<String>>();
//    keySet.forEach((key) {
//      fieldValues[key] = tagDicts.map((a) => a[key]).cast<String>().toList();
//    });
