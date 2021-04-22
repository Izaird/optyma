// To parse this JSON data, do
//
//     final LogroModel = logrosModelFromJson(jsonString);

import 'dart:convert';

LogroModel logrosModelFromJson(String str) => LogroModel.fromJson(json.decode(str));

String logrosModelToJson(LogroModel data) => json.encode(data.toJson());

class LogroModel {
    LogroModel({
        this.id,
        this.nombre,
        this.descripcion,
    });

    String id;
    String nombre;
    String descripcion;

    factory LogroModel.fromJson(Map<String, dynamic> json) => LogroModel(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
    };
}
