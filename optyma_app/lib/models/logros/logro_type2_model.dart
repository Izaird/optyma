
// To parse this JSON data, do
//
//     final LogroModel = logrosModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

LogroType2Model logrosModelFromJson(String str) => LogroType2Model.fromJson(json.decode(str));

String logrosModelToJson(LogroType2Model data) => json.encode(data.toJson());

class LogroType2Model {
    LogroType2Model({
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

    factory LogroType2Model.fromJson(Map<String, dynamic> json) => LogroType2Model(
        id          : json["id"],
        name        : json["name"],
        description : json["description"],
        difficulty  : json["difficulty"],
        subject     : json["subject"],
    );

    factory LogroType2Model.fromSnapshot(DocumentSnapshot snapshot){
      return LogroType2Model(
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
