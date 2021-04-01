import 'package:flutter/material.dart';
import 'package:optyma/theme/app_theme.dart';

// *  textInputType - The type of information for which to optimize the text input control.
/// *  hintText - Text that suggests what sort of input the field accepts.
/// *  prefixIcon - Pass Icon if required
/// *  defaultText - If there is predefined value is there for a text field
/// *  obscureText - Is Password field?
/// *  actionKeyboard - Keyboard action eg. next, done, search, etc
class DropDownWidget extends StatefulWidget {

  final String hintText;
  final Widget prefixIcon;
  final String defaultText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final List<String> items;


  const DropDownWidget({
      this.hintText,
      this.prefixIcon,
      this.defaultText,
      this.validator,
      this.onSaved,
      @required this.items,
      });

  @override
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  double bottomPaddingToError = 12;
  String aux;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: AppTheme.colors.darkCornflowerBlue,
      ),
      child: DropdownButtonFormField(
        onChanged: (value){
          setState(() {
            
          });  
        },
        items: widget.items.map((valueItem){
          return DropdownMenuItem(
            value: valueItem,
            child: Text(valueItem),
          );
        }).toList(),
        style: TextStyle(
          color: AppTheme.colors.black,
          fontSize: 16.0,
          fontWeight: FontWeight.w300,
          fontStyle: FontStyle.normal,
          letterSpacing: 1.2,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
              top: 12, bottom: bottomPaddingToError, left: 8.0, right: 8.0),
          prefixIcon: widget.prefixIcon,
          hintText: widget.hintText,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.colors.powderBlue),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.colors.blueGreen),
          ),
          hintStyle: TextStyle(
            color: AppTheme.colors.black,
            fontSize: 14.0,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.normal,
            letterSpacing: 1.2,
          ),
          isDense: true,
          errorStyle: TextStyle(
            color: AppTheme.colors.red,
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            letterSpacing: 1.2,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.colors.blueGreen),
          ),
        ),
        validator: widget.validator,
        onSaved: widget.onSaved,

      ),
    );
  }
}
