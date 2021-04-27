// To parse this JSON data, do
//
//     final LogroModel = logrosModelFromJson(jsonString);

import 'dart:convert';

LogroModel logrosModelFromJson(String str) => LogroModel.fromJson(json.decode(str));

String logrosModelToJson(LogroModel data) => json.encode(data.toJson());

class LogroModel {
    LogroModel({
        this.id,
        this.name,
        this.description,
    });

    String id;
    String name;
    String description;

    factory LogroModel.fromJson(Map<String, dynamic> json) => LogroModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
    };
}
