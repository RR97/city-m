class Tour {
  String name;
  List<String> destinations;

  Tour(this.name, this.destinations);

  factory Tour.fromJson(dynamic json) {
    return Tour(json['name'] as String, json['destinations'] as List<String>);
  }

}

class Tours {
  // List with possible tours
  static var toursJson = [
    {
      "name": "Campus Tour",
      "destinations": ['A','B']
    },
    {
      "name": "Short City Tour",
      "destinations": ['C','D']
    }
  ];

  static List<Tour> getToursList() {
    return toursJson.map((tour) => Tour.fromJson(tour)).toList();
  }
}