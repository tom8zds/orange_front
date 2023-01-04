// To parse this JSON data, do
//
//     final calendarData = calendarDataFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CalendarData calendarDataFromJson(String str) =>
    CalendarData.fromJson(json.decode(str));

String calendarDataToJson(CalendarData data) => json.encode(data.toJson());

class CalendarData {
  CalendarData({
    required this.year,
    required this.season,
    required this.table,
  });

  final int year;
  final int season;
  final Map<WeekDay, List<AnimeData>> table;

  factory CalendarData.fromJson(Map<String, dynamic> json) => CalendarData(
        year: json["year"],
        season: json["season"],
        table: Map.from(json["table"]).map(
          (k, v) => MapEntry<WeekDay, List<AnimeData>>(
            WeekDay.values.elementAt(int.parse(k)),
            List<AnimeData>.from(
              v.map(
                (x) => AnimeData.fromJson(x),
              ),
            ),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "year": year,
        "season": season,
        "table": Map.from(table).map((k, v) => MapEntry<String, dynamic>(
            (k as WeekDay).name, List<dynamic>.from(v.map((x) => x.toJson())))),
      };
}

class AnimeData {
  AnimeData({
    required this.id,
    required this.name,
    required this.cover,
  });

  final String id;
  final String name;
  final String cover;

  factory AnimeData.fromJson(Map<String, dynamic> json) => AnimeData(
        id: json["id"],
        name: json["name"],
        cover: json["cover"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cover": cover,
      };
}

enum WeekDay { unknown, mon, tue, wed, thu, fri, sat, sun }

const Map<WeekDay, String> weekDayMap = {
  WeekDay.unknown: "其他",
  WeekDay.mon: "周一",
  WeekDay.tue: "周二",
  WeekDay.wed: "周三",
  WeekDay.thu: "周四",
  WeekDay.fri: "周五",
  WeekDay.sat: "周六",
  WeekDay.sun: "周日",
};

extension WeekDayZH on WeekDay {
  String get name => weekDayMap[this] ?? "其他";
}
