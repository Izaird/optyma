import 'package:flutter/material.dart';
import 'package:optyma/theme/colors.dart';


@immutable
class AppTheme {
 static const colors = AppColors();

 const AppTheme._();


 static ThemeData define(){
   return ThemeData(
     fontFamily: "SFRegular",
     primaryColor: Color(0xFF067bb2),
     accentColor: Color(0xFF055089),
     focusColor: Color(0xFF49f385),
   );
 }
}