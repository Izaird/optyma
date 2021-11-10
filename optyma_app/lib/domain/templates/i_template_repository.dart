


import 'package:dartz/dartz.dart';
import 'package:optyma_app/domain/templates/template.dart';
import 'package:optyma_app/domain/templates/template_failure.dart';

abstract class ITemplateRepository{
  Future<Either<TemplateFailure, List<Template>>> getAllTemplates();
  Stream<Either<TemplateFailure, List<Template>>> watchAll();
  Future<Either<TemplateFailure, Unit>> create(Template template);
  Future<Either<TemplateFailure, Unit>> update(Template template);
  Future<Either<TemplateFailure, Unit>> delete(Template template);
}