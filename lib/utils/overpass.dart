import 'http.dart';

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

// Map<String, dynamic> getTags(Map<String, dynamic> map) => map["tags"];
// List<String> getKeys(Map<String, dynamic> map) => map.keys.toList();

//    final tagDicts = elements.map(getTags).cast<Map<String, dynamic>>();
//    final keySet = tagDicts.expand(getKeys);
//
//    final fieldValues = Map<String, List<String>>();
//    keySet.forEach((key) {
//      fieldValues[key] = tagDicts.map((a) => a[key]).cast<String>().toList();
//    });
