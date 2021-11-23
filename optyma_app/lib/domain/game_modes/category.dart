import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:optyma_app/domain/expressions/i_expression_facade.dart';

part 'category.freezed.dart';

@freezed
class Category with _$Category{
  const factory Category({
    required String id,
    required String name,
    required Icon icon,
  }) = _Category;
}


const List<Category> gameCategories = [
  Category(id: 'endless-mode', name: 'Infinito' , icon: Icon(FontAwesomeIcons.infinity)),
  Category(id: 'pvp', name: 'Jugador Vs Jugador' , icon: Icon(FontAwesomeIcons.peopleArrows)),
  Category(id:'classic-mode' , name: 'Clásico' , icon: Icon(FontAwesomeIcons.plusSquare)),
  // Category(id: 4, name: 'Infinito' , icon: Icon(FontAwesomeIcons.infinity)),
];


List<Category> operationsCategories = [
  Category(
    id: EnumToString.convertToString(OperationType.addition), 
    name: 'Suma' , 
    icon: const Icon(FontAwesomeIcons.plus)
  ),
  Category(
    id: EnumToString.convertToString(OperationType.substraction), 
    name: 'Resta' , 
    icon: const Icon(FontAwesomeIcons.minus)
  ),
  Category(
    id: EnumToString.convertToString(OperationType.multiplication), 
    name: 'Multiplicación' ,
    icon: const Icon(FontAwesomeIcons.times)
  ),
  Category(
    id: EnumToString.convertToString(OperationType.division), 
    name: 'División' , 
    icon: const Icon(FontAwesomeIcons.divide)
  ),
  Category(
    id: EnumToString.convertToString(OperationType.combined),
    name: 'Combinado', 
    icon: const Icon(FontAwesomeIcons.question)),
];


List<Category> difficultysCategories = [
  Category(
    id: EnumToString.convertToString(Difficulty.easy), 
    name: 'Fácil' , 
    icon: const Icon(Icons.no_encryption)
  ),
  Category(
    id: EnumToString.convertToString(Difficulty.medium), 
    name: 'Intermedio' , 
    // ignore: prefer_const_constructors
    icon: Icon(FontAwesomeIcons.accusoft)
  ),
  Category(
    id: EnumToString.convertToString(Difficulty.hard), 
    name: 'Difícil' ,
    icon: const Icon(FontAwesomeIcons.blackTie)
  ),
];