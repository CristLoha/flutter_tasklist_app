import 'dart:convert';

class AddTaskRequestModel {
  final Data data;

  AddTaskRequestModel({
    required this.data,
  });

  factory AddTaskRequestModel.fromRawJson(String str) =>
      AddTaskRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddTaskRequestModel.fromJson(Map<String, dynamic> json) =>
      AddTaskRequestModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  final String title;
  final String description;

  Data({
    required this.title,
    required this.description,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
      };
}
