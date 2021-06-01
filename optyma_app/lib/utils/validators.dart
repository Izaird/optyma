final RegExp _nameRegExp = RegExp(
  r"[A-Za-z]+([\ A-Za-z]+)*");

final RegExp _textRegExp = RegExp(
  r"^[a-zA-Z0-9áéíóú ]{4,}"
);
final RegExp _valuesExp = RegExp(
  r"^(\d*-\d*;)+$"
);
final RegExp _plantillaRegExp = RegExp(
  r"^[(]?\w*\w(?:[+*-/=^)]\w*\w[)]?)+[;]?(\d*-\d*;)*$"
);
final RegExp _plantillaTimeExp = RegExp(
  r"^\d+$"
);
final RegExp _emailRegExp = RegExp(
  r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");

final RegExp _passwordRegExp = RegExp(
  r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");

bool isPlantilla(String value){ 
  if(value.isEmpty) return false;
  return _plantillaRegExp.hasMatch(value);
}
bool isDigit(String value){ 
  if(value.isEmpty) return false;
  return _plantillaTimeExp.hasMatch(value);
}
bool isValues(String value){ 
  if(value.isEmpty) return false;
  return _valuesExp.hasMatch(value);
}
bool isName(String value){ 
  if(value.isEmpty) return false;
  return _nameRegExp.hasMatch(value);
}

bool isEmail(String value){
  if(value.isEmpty) return false;
  return _emailRegExp.hasMatch(value);
}

bool isPassword(String value){
  if(value.isEmpty) return false;
  return _passwordRegExp.hasMatch(value);
}

bool isText(String value){
  if(value.isEmpty) return false;
  return _textRegExp.hasMatch(value);
}