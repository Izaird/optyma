import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:optyma_app/domain/templates/i_template_repository.dart';
import 'package:optyma_app/domain/templates/template.dart';
import 'package:optyma_app/domain/templates/template_failure.dart';
import 'package:optyma_app/infrestucture/core/firestore_helpers.dart';
import 'package:optyma_app/infrestucture/templates/template_dtos.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton(as: ITemplateRepository)
class TemplateRepository implements ITemplateRepository{

  final FirebaseFirestore _firestore;
  TemplateRepository(this._firestore);



  @override
  Future<Either<TemplateFailure, Unit>> create(Template template)async {
    try {
      final templateRef = await _firestore.templateReference();
      final templateDto = TemplateDto.fromDomain(template);

      await templateRef.add(templateDto.toJson());

      return right(unit);
      
    } on FirebaseException catch (e) {
      if(e.message!.contains('PERMISSION_DENIED')){
        return left(const TemplateFailure.insufficientPermission());
      }else{
        debugPrint(e.toString());
        return left(const TemplateFailure.unexpected());
      }
    }
  }

  @override
  Future<Either<TemplateFailure, Unit>> update(Template template) async{
    try {
      final templateRef = await _firestore.templateReference();
      final templateDto = TemplateDto.fromDomain(template);

      await templateRef.doc(template.id.getOrCrash()).update(templateDto.toJson());

      return right(unit);
      
    } on FirebaseException catch (e) {
      if(e.message!.contains('PERMISSION_DENIED')){
        return left(const TemplateFailure.insufficientPermission());
      }else if(e.message!.contains('NOT_FOUND')){
        return left(const TemplateFailure.unableToUpdate());
      }else{
        debugPrint(e.toString());
        return left(const TemplateFailure.unexpected());
      }
    }
  }

  @override
  Future<Either<TemplateFailure, Unit>> delete(Template template) async{
    try {
      final templateRef = await _firestore.templateReference();

      await templateRef.doc(template.id.getOrCrash()).delete();

      return right(unit);
      
    } on FirebaseException catch (e) {
      if(e.message!.contains('PERMISSION_DENIED')){
        return left(const TemplateFailure.insufficientPermission());
      }else if(e.message!.contains('NOT_FOUND')){
        return left(const TemplateFailure.unableToUpdate());
      }else{
        debugPrint(e.toString());
        return left(const TemplateFailure.unexpected());
      }
    }
  }

  @override
  Stream<Either<TemplateFailure, List<Template>>> watchAll() async*{
    final templatesRef = await _firestore.templateReference();

    yield* templatesRef
      .snapshots()
      .map(
        (snapshot) => right<TemplateFailure, List<Template>>(
          snapshot.docs
            .map((doc) => TemplateDto.fromFirestore(doc).toDomain())
            .toList()
        )
      )
      .onErrorReturnWith((e, s) {
        if(e is FirebaseException && e.message!.contains('PERMISSION_DENIED')){
          return left(const TemplateFailure.insufficientPermission());
        }else{
          debugPrint(e.toString());
          return left(const TemplateFailure.unexpected());
        }
      });
  }

}