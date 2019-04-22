import 'Store.dart';

enum ProducerType { anime }

ProducerType parseProducerType(String type) {
  if (type == "anime") {
    return ProducerType.anime;
  }
  print("Unknown producer type $type");
  return null;
}

String printProducerType(ProducerType type) {
  switch (type) {
    case ProducerType.anime:
      return "Anime";
    default:
      return "Ugh";
  }
}

class Producer {
  int malId;
  ProducerType type;
  String name;
  String url;

  void _assignFromMalJson(Map<String, dynamic> producer) {
    malId = producer["mal_id"];
    type = parseProducerType(producer["type"]);
    name = producer["name"];
    url = producer["url"];
  }

  Producer._fromMalJson(Map<String, dynamic> producer) {
    _assignFromMalJson(producer);
  }

  factory Producer.getFromMalJson(Map<String, dynamic> producer) {
    final malId = producer["mal_id"];
    return Store.producerList.producers.update(malId, (entry) {
      entry._assignFromMalJson(producer);
      return entry;
    }, ifAbsent: () => Producer._fromMalJson(producer));
  }
}
