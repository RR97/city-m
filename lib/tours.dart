class Tour {
  String name;
  List<String> destinations;
  String info;
  List<String> transportTypes;

  Tour(this.name, this.destinations, this.info, this.transportTypes);

  factory Tour.fromJson(dynamic json) {
    return Tour(
        json['name'] as String,
        json['destinations'] as List<String>,
        json['info'] as String,
        json['transport'] as List<String>
    );
  }

}

class Tours {
  // List with possible tours
  static var toursJson = [
    {
      "name": "Campus Tour",
      "destinations": ['A','B'],
      "info": "TOUR INFO 1",
      "transport": ['Walking', 'Bike']
    },
    {
      "name": "Short City Tour",
      "destinations": ['C','D'],
      "info": "TOUR INFO 2",
      "transport": ['Walking', 'Bus', 'Bike', 'U-Bahn', 'Tram']
    }
  ];

  static List<Tour> getToursList() {
    return toursJson.map((tour) => Tour.fromJson(tour)).toList();
  }
}