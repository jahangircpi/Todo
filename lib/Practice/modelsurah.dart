import 'dart:convert';

Surahlists surahlistsFromJson(String str) =>
    Surahlists.fromJson(json.decode(str));

String surahlistsToJson(Surahlists data) => json.encode(data.toJson());

class Surahlists {
  Surahlists({
    this.code,
    this.status,
    this.data,
  });

  int code;
  String status;
  List<Datum> data;

  factory Surahlists.fromJson(Map<String, dynamic> json) => Surahlists(
        code: json["code"],
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.number,
    this.name,
    this.englishName,
    this.englishNameTranslation,
    this.numberOfAyahs,
    this.revelationType,
  });

  int number;
  String name;
  String englishName;
  String englishNameTranslation;
  int numberOfAyahs;
  String revelationType;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        number: json["number"],
        name: json["name"],
        englishName: json["englishName"],
        englishNameTranslation: json["englishNameTranslation"],
        numberOfAyahs: json["numberOfAyahs"],
        revelationType: json["revelationType"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "name": name,
        "englishName": englishName,
        "englishNameTranslation": englishNameTranslation,
        "numberOfAyahs": numberOfAyahs,
        "revelationType": revelationType,
      };
}
