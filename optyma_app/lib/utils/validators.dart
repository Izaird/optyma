final RegExp _textRegExp = RegExp(
  //TODO: Change the regexp so that only one name is required and  the second one is optional
  r"^[A-Z][a-z]+\s[A-Z][a-z]+$");

final RegExp _emailRegExp = RegExp(
  r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");

final RegExp _passwordRegExp = RegExp(
  r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");

bool isText(String value){ 
  if(value.isEmpty) return false;

  return _textRegExp.hasMatch(value);
}


bool isEmail(String value){
  if(value.isEmpty) return false;

  return _emailRegExp.hasMatch(value);
}


bool isPassword(String value){
  if(value.isEmpty) return false;

  return _passwordRegExp.hasMatch(value);
}