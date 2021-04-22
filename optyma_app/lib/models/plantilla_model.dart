// To parse this JSON data, do
//
//     final plantillasModel = plantillasModelFromJson(jsonString);
// To parse this JSON data, do
//
//     final plantillaModel = plantillaModelFromJson(jsonString);

import 'dart:convert';

PlantillaModel plantillaModelFromJson(String str) => PlantillaModel.fromJson(json.decode(str));

String plantillaModelToJson(PlantillaModel data) => json.encode(data.toJson());

class PlantillaModel {
    PlantillaModel({
        this.dificultad,
        this.expresion,
        this.sentencia,
        this.tema,
        this.tiempoAbierta,
        this.tiempoCerrada,
        this.timestamp,
        this.uid,
    });

    int dificultad;
    String expresion;
    String sentencia;
    String tema;
    int tiempoAbierta;
    int tiempoCerrada;
    DateTime timestamp;
    String uid;

    factory PlantillaModel.fromJson(Map<String, dynamic> json) => PlantillaModel(
        dificultad: json["dificultad"],
        expresion: json["expresion"],
        sentencia: json["sentencia"],
        tema: json["tema"],
        tiempoAbierta: json["tiempoAbierta"],
        tiempoCerrada: json["tiempoCerrada"],
        timestamp: json["timestamp"],
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "dificultad": dificultad,
        "expresion": expresion,
        "sentencia": sentencia,
        "tema": tema,
        "tiempoAbierta": tiempoAbierta,
        "tiempoCerrada": tiempoCerrada,
        "timestamp": timestamp,
        "uid": uid,
    };
}
