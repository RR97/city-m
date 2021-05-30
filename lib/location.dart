class Location {
  final String name;
  final String info;

  Location({ this.info, this.name });

  Location.fromJson(Map<String, Object> json) : this(
    info: json['info'] as String,
    name: json['name'] as String,
  );

  Map<String, Object> toJson() {
    return {
      'name': name,
      'info': info,
    };
  }

}