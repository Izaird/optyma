import 'package:dartz/dartz.dart';
import 'value_failure.dart';

Either<ValueFailure<String>, String> validateEmailAddress(String input) {
  const emailRegex =
      r"""^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$""";
  if (RegExp(emailRegex).hasMatch(input)) {
    return right(input);
  } else {
    return left(ValueFailure.invalidEmail(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validatePassword(String input) {
  const passwordRegex = 
  r"""^[a-zA-Z0-9!"#\$%&'\(\)\*\+,-\.\/:;<=>\?@[\]\^_`\{\|}~]{8,}$""";

  if (RegExp(passwordRegex).hasMatch(input)) {
    return right(input);
  } else {
    return left(ValueFailure.invalidPassword(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validateMaxStringLength(
  String input,
  int maxLength
) {
  if(input.length <= maxLength){
    return right(input);
  }else{
    return left(
      ValueFailure.exceedingLength(failedValue: input, max: maxLength),
    );
  }
}

Either<ValueFailure<String>, String> validateStringNotEmpty(String input) {
  if(input.isNotEmpty){
    return right(input);
  }else{
    return left(
      ValueFailure.empty(failedValue: input),
    );
  }
}

Either<ValueFailure<String>, String> validateSingleLine(String input) {
  if(!input.contains('\n')){
    return right(input);
  }else{
    return left(
      ValueFailure.multiline(failedValue: input)
    );
  }
}

Either<ValueFailure<String>, String> validateExpression(String input){
  const expressionRegex = 
  r"""^[(]*\w(?:[+/*-][()]*\w[)]*)+$""";

  if(RegExp(expressionRegex).hasMatch(input)){
    return right(input);
  }else{
    return left(ValueFailure.invalidExpression(failedValue: input));
  }
}

