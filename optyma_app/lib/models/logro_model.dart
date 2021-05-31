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
        this.type,
        this.numberOfDays,
        this.numberOfExercises,
        this.numberOfAnswers,
        this.difficulty,
        this.subject
    });

    String id;
    String name;
    String description;
    int type;
    int numberOfDays;
    int numberOfAnswers;
    int numberOfExercises;
    int difficulty;
    int subject;

    factory LogroModel.fromJson(Map<String, dynamic> json) => LogroModel(
        id: json["id"] ??  null,
        name: json["name"]??  null,
        description: json["description"]??  null,
        type: json["type"] ?? null,
        numberOfDays: json["numberOfDays"]??  null,
        numberOfExercises: json["numberOfExercises"]??  null,
        numberOfAnswers: json["numberOfAnswers"]??  null,
        difficulty: json["difficulty"]??  null,
        subject: json["subject"]??  null
    );

    factory LogroModel.fromSnapshot(DocumentSnapshot snapshot){
      return LogroModel(
        id                : snapshot.id,
        name              : snapshot.data()['name'] ?? null,
        description       : snapshot.data()['description'] ?? null,
        type              : snapshot.data()["type"] ?? null,
        numberOfDays      : snapshot.data()["numberOfDays"] ?? null,
        numberOfExercises : snapshot.data()["numberOfExercises"] ??  null,
        numberOfAnswers   : snapshot.data()["numberOfAnswers"] ??  null,
        difficulty        : snapshot.data()["difficulty"] ??  null,
        subject           : snapshot.data()["subject"] ??  null,
      );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "type": type,
        "numberofDays": numberOfDays,
        "numberofAnswers": numberOfAnswers,
        "numberofExercises": numberOfExercises,
        "difficulty":difficulty,
        "subject":subject,
    };
}
