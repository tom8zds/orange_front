// To parse this JSON data, do
//
//     final subscribeIndex = subscribeIndexFromJson(jsonString);
import 'dart:convert';

List<SubscribeItem> subscribeItemFromJson(String str) =>
    List<SubscribeItem>.from(
        json.decode(str).map((x) => SubscribeItem.fromJson(x)));

String subscribeItemToJson(List<SubscribeItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubscribeItem {
  SubscribeItem({
    required this.name,
    required this.updateTime,
    required this.cover,
    required this.id,
    required this.bangumiName,
    required this.episode,
    required this.status,
    required this.updatedTime,
    required this.player,
  });

  final String name;
  final String updateTime;
  final String cover;
  final int id;
  final String bangumiName;
  final int episode;
  final int status;
  final int updatedTime;
  final Player player;

  factory SubscribeItem.fromJson(Map<String, dynamic> json) => SubscribeItem(
        name: json["name"],
        updateTime: json["update_time"],
        cover: json["cover"],
        id: json["id"],
        bangumiName: json["bangumi_name"],
        episode: json["episode"],
        status: json["status"],
        updatedTime: json["updated_time"],
        player: Player.fromJson(json["player"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "update_time": updateTime,
        "cover": cover,
        "id": id,
        "bangumi_name": bangumiName,
        "episode": episode,
        "status": status,
        "updated_time": updatedTime,
        "player": player.toJson(),
      };
}

class Player {
  Player();

  factory Player.fromJson(Map<String, dynamic> json) => Player();

  Map<String, dynamic> toJson() => {};
}
