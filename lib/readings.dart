import 'dart:convert';

Readings readingsFromJson(String str) {
  final jsonData = json.decode(str);
  return Readings.fromMap(jsonData);
}

String readingsToJson(Readings data) {
  final dyn = data.toMap();
  return json.decode(dyn.toString());
}

class Readings {
  int current;
  String house;
  int month;
  int year;

  Readings({this.house, this.month, this.year, this.current});

  factory Readings.fromMap(Map<String, dynamic> json) => new Readings(
      current: json["current"],
      house: json["house"],
      month: json["month"],
      year: json["year"]);

  Map<String, dynamic> toMap() =>
      {"current": current, "house": house, "year": year, "month": month};
}
