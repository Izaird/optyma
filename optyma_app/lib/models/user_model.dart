// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        this.uid,
        this.name,
        this.email,
        this.admin,
    });

    String uid;
    String name;
    String email;
    bool admin;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json["uid"],
        name: json["name"],
        email: json["email"],
        admin: json["admin"],
    );

    factory UserModel.fromSnapshot(DocumentSnapshot snapshot){
      return UserModel(
        uid   : snapshot.data()['uId'],
        name  : snapshot.data()['name'],
        email : snapshot.data()['email'],
        admin : snapshot.data()['admin'],
      );
    }

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "email": email,
        "admin": admin,
    };
}
