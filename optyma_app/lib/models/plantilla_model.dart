// To parse this JSON data, do
//
//     final plantillasModel = plantillasModelFromJson(jsonString);
// To parse this JSON data, do
//
//     final plantillaModel = plantillaModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

PlantillaModel plantillaModelFromJson(String str) => PlantillaModel.fromJson(json.decode(str));

String plantillaModelToJson(PlantillaModel data) => json.encode(data.toJson());

class PlantillaModel {
    PlantillaModel({
        this.difficulty,
        this.expression,
        this.sentence,
        this.subject,
        this.values,
        this.timeOpen,
        this.timeClose,
        this.timestamp,
        this.uid,
        this.id,
    });

    int difficulty;
    String expression;
    String sentence;
    String values;
    int subject;
    int timeOpen;
    int timeClose;
    DateTime timestamp;
    String uid;
    String id;

    factory PlantillaModel.fromJson(Map<String, dynamic> json) => PlantillaModel(
        difficulty: json["difficulty"],
        expression: json["expression"],
        sentence: json["sentence"],
        subject: json["subject"],
        values : json["values"],
        timeOpen: json["timeOpen"],
        timeClose: json["timeClose"],
        timestamp: json["timestamp"],
        uid: json["uid"],
    );

    factory PlantillaModel.fromSnapshot(DocumentSnapshot snapshot){
      return PlantillaModel(
        id            :snapshot.id,
        difficulty    : snapshot.data()['difficulty'],
        expression           : snapshot.data()['expression'],
        sentence     : snapshot.data()['sentence'],
        values: snapshot.data()['values'],
        subject          : snapshot.data()['subject'],
        timeOpen : snapshot.data()['timeOpen'],
        timeClose : snapshot.data()['timeClose'],
      );
    }

    Map<String, dynamic> toJson() => {
        "difficulty": difficulty,
        "expression": expression,
        "sentence": sentence,
        "values": values,
        "subject": subject,
        "timeOpen": timeOpen,
        "timeClose": timeClose,
        "timestamp": timestamp,
        "uid": uid,
    };
}