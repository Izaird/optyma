import 'package:dartz/dartz.dart';
import 'package:optyma_app/domain/core/value_failure.dart';
import 'package:optyma_app/domain/core/value_objects.dart';
import 'package:optyma_app/domain/core/value_validators.dart';

class Expression extends ValueObject<String>{
  @override 
  final Either<ValueFailure<String>, String> value;

  factory Expression(String input){
    return Expression._(
      validateExpression(input)
    );
  }

  const Expression._(this.value);

}