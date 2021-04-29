// To parse this JSON data, do
//
//     final LogroModel = logrosModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

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

    factory LogroModel.fromSnapshot(DocumentSnapshot snapshot){
      return LogroModel(
        id          : snapshot.id,
        name        : snapshot.data()['nombre'],
        description : snapshot.data()['descripcion'],
      );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
    };
}
