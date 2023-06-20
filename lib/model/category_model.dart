import 'dart:convert';

List<String?>? categoryFromJson(String str) => json.decode(str) == null ? [] : List<String?>.from(json.decode(str)!.map((x) => x));

String categoryToJson(List<String?>? data) => json.encode(data == null ? [] : List<dynamic>.from(data.map((x) => x)));
