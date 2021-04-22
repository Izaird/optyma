final RegExp _expresionRegExp = RegExp(
  r"[a-zA-Z ]{10,}");

bool isText(String value){ 
  if(value.isEmpty) return false;

  return _expresionRegExp.hasMatch(value);
}