import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:optyma_app/domain/core/value_objects.dart';
import 'package:optyma_app/domain/templates/template.dart';
import 'package:optyma_app/domain/templates/value_objects.dart';

part 'template_dtos.freezed.dart';
part 'template_dtos.g.dart';

@freezed
class TemplateDto with _$TemplateDto{
  const factory TemplateDto({
    @JsonKey(ignore: true) String? id,
    required String expression,
  }) = _TemplateDto;

  const TemplateDto._();

  factory TemplateDto.fromDomain(Template template){
    return TemplateDto(
      expression: template.expression.getOrCrash(),
    );
  }

  factory TemplateDto.fromJson(Map<String, dynamic> json) => _$TemplateDtoFromJson(json);


  factory TemplateDto.fromFirestore(DocumentSnapshot doc){
    return TemplateDto.fromJson(doc.data()! as Map<String, dynamic>)
      .copyWith(id: doc.id);
  }

  Template toDomain(){
    return Template(
      id: UniqueId.fromUniqueString(id!), 
      expression: Expression(expression)
    );
  }
}


class ServerTimeStampConverter implements JsonConverter<FieldValue, Object>{
  const ServerTimeStampConverter();

  @override 
  FieldValue fromJson(Object json){
    return FieldValue.serverTimestamp();
  }

  @override
  Object toJson(FieldValue fieldValue) => fieldValue;
}