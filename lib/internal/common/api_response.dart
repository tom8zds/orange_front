import 'dart:convert';

ApiResponse apiResponseFromJson(String str) =>
    ApiResponse.fromJson(json.decode(str));

String apiResponseToJson(ApiResponse data) => json.encode(data.toJson());

class ApiResponse {
  ApiResponse({
    required this.version,
    required this.latestVersion,
    required this.frontendVersion,
    required this.status,
    required this.lang,
    required this.danmakuApi,
    required this.data,
  });

  final String version;
  final String latestVersion;
  final String frontendVersion;
  final String status;
  final String lang;
  final String danmakuApi;
  final String data;

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        version: json["version"],
        latestVersion: json["latest_version"],
        frontendVersion: json["frontend_version"],
        status: json["status"],
        lang: json["lang"],
        danmakuApi: json["danmaku_api"],
        data: jsonEncode(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "version": version,
        "latest_version": latestVersion,
        "frontend_version": frontendVersion,
        "status": status,
        "lang": lang,
        "danmaku_api": danmakuApi,
        "data": data,
      };
}
