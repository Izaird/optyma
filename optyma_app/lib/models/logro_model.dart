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
        this.numberofDays,
        this.numberofExercises,
        this.numberofAnswers,
        this.difficulty,
        this.subject
    });

    String id;
    String name;
    String description;
    String type;
    int numberofDays;
    int numberofAnswers;
    int numberofExercises;
    int difficulty;
    int subject;

    factory LogroModel.fromJson(Map<String, dynamic> json) => LogroModel(
        id: json["id"] ??  null,
        name: json["name"]??  null,
        description: json["description"]??  null,
        type: json["type"],
        numberofDays: json["numberofDays"]??  null,
        numberofExercises: json["numberOfExercises"]??  null,
        numberofAnswers: json["numberofAnswers"]??  null,
        difficulty: json["difficulty"]??  null,
        subject: json["subject"]??  null
    );

    factory LogroModel.fromSnapshot(DocumentSnapshot snapshot){
      return LogroModel(
        id                : snapshot.id,
        name              : snapshot.data()['name']??  null ,
        description       : snapshot.data()['description']??  null,
        type              : snapshot.data()["type"]?? null ,
        numberofDays      : snapshot.data()["numberofDays"]??  null,
        numberofExercises : snapshot.data()["numberOfExercises"]??  null,
        numberofAnswers   : snapshot.data()["numberofAnswers"]??  null,
        difficulty        : snapshot.data()["difficulty"]??  null,
        subject           : snapshot.data()["subject"]??  null
      );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "type": type,
        "numberofDays": numberofDays,
        "numberofAnswers": numberofAnswers,
        "numberofExercises": numberofExercises,
        "difficulty":difficulty,
        "subject":subject,
    };
}
