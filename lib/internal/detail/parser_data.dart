import 'dart:convert';

List<ParserData> parserDataFromJson(dynamic data) => List<ParserData>.from(
    (data as Iterable).map((x) => ParserData.fromJson(x)));

String parserDataToJson(List<ParserData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ParserData {
  ParserData({
    required this.id,
    required this.seasonId,
    required this.name,
    required this.seasonName,
    required this.cover,
    required this.overview,
  });

  final int id;
  final int seasonId;
  final String name;
  final String seasonName;
  final String cover;
  final String overview;

  factory ParserData.fromJson(Map<String, dynamic> json) => ParserData(
        id: json["id"],
        seasonId: json["season_id"],
        name: json["name"],
        seasonName: json["season_name"],
        cover: json["cover"],
        overview: json["overview"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "season_id": seasonId,
        "name": name,
        "season_name": seasonName,
        "cover": cover,
        "overview": overview,
      };
}
