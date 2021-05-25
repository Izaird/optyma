
// To parse this JSON data, do
//
//     final LogroModel = logrosModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

LogroType1Model logrosModelFromJson(String str) => LogroType1Model.fromJson(json.decode(str));

String logrosModelToJson(LogroType1Model data) => json.encode(data.toJson());

class LogroType1Model {
    LogroType1Model({
        this.id,
        this.name,
        this.description,
        this.difficulty,
        this.subject
    });

    String id;
    String name;
    String description;
    int difficulty;
    int subject;

    factory LogroType1Model.fromJson(Map<String, dynamic> json) => LogroType1Model(
        id          : json["id"],
        name        : json["name"],
        description : json["description"],
        difficulty  : json["difficulty"],
        subject     : json["subject"],
    );

    factory LogroType1Model.fromSnapshot(DocumentSnapshot snapshot){
      return LogroType1Model(
        id          : snapshot.id,
        name        : snapshot.data()['name'],
        description : snapshot.data()['description'],
        difficulty  : snapshot.data()['difficulty'],
        subject     : snapshot.data()['subject'],
      );
    }

    Map<String, dynamic> toJson() => {
        "id"          : id,
        "name"        : name,
        "description" : description,
        "difficulty"  : difficulty,
        "subject"     : subject,
    };
}
