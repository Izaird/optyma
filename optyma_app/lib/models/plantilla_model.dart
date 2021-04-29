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
        this.dificultad,
        this.exp,
        this.sentencia,
        this.tema,
        this.tiempoAbierta,
        this.tiempoCerrada,
        this.timestamp,
        this.uid,
        this.id,
    });

    int dificultad;
    String exp;
    String sentencia;
    String tema;
    int tiempoAbierta;
    int tiempoCerrada;
    DateTime timestamp;
    String uid;
    String id;

    factory PlantillaModel.fromJson(Map<String, dynamic> json) => PlantillaModel(
        dificultad: json["dificultad"],
        exp: json["exp"],
        sentencia: json["sentencia"],
        tema: json["tema"],
        tiempoAbierta: json["tiempoAbierta"],
        tiempoCerrada: json["tiempoCerrada"],
        timestamp: json["timestamp"],
        uid: json["uid"],
    );

    factory PlantillaModel.fromSnapshot(DocumentSnapshot snapshot){
      return PlantillaModel(
        id            :snapshot.id,
        dificultad    : snapshot.data()['dificultad'],
        exp           : snapshot.data()['exp'],
        sentencia     : snapshot.data()['sentencia'],
        tema          : snapshot.data()['tema'],
        tiempoAbierta : snapshot.data()['tiempoAbierta'],
        tiempoCerrada : snapshot.data()['tiempoCerrada'],
      );
    }

    Map<String, dynamic> toJson() => {
        "dificultad": dificultad,
        "exp": exp,
        "sentencia": sentencia,
        "tema": tema,
        "tiempoAbierta": tiempoAbierta,
        "tiempoCerrada": tiempoCerrada,
        "timestamp": timestamp,
        "uid": uid,
    };
}