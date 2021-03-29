import 'package:flutter/material.dart';
import 'package:optyma/theme/app_theme.dart';

// *  textInputType - The type of information for which to optimize the text input control.
/// *  hintText - Text that suggests what sort of input the field accepts.
/// *  prefixIcon - Pass Icon if required
/// *  defaultText - If there is predefined value is there for a text field
/// *  obscureText - Is Password field?
/// *  parametersValidate - Value to vslidate
/// *  actionKeyboard - Keyboard action eg. next, done, search, etc
class TextFormFieldWidget extends StatefulWidget {
  final TextInputType textInputType;
  final String hintText;
  final Widget prefixIcon;
  final String defaultText;
  final bool obscureText;
  final String parametersValidate;
  final TextInputAction actionKeyboard;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;


  const TextFormFieldWidget(
      {@required 
      this.textInputType,
      this.hintText,
      this.prefixIcon,
      this.defaultText,
      this.obscureText = false,
      this.parametersValidate,
      this.actionKeyboard = TextInputAction.next,
      this.validator,
      this.onSaved,
      });

  @override
  _TextFormFieldWidgetState createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  double bottomPaddingToError = 12;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: AppTheme.colors.powderBlue,
      ),
      child: TextFormField(
        cursorColor: AppTheme.colors.powderBlue,
        obscureText: widget.obscureText,
        keyboardType: widget.textInputType,
        textInputAction: widget.actionKeyboard,
        style: TextStyle(
          color: AppTheme.colors.black,
          fontSize: 16.0,
          fontWeight: FontWeight.w200,
          fontStyle: FontStyle.normal,
          letterSpacing: 1.2,
        ),
        initialValue: widget.defaultText,
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          hintText: widget.hintText,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.colors.powderBlue),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.colors.powderBlue),
          ),
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 14.0,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.normal,
            letterSpacing: 1.2,
          ),
          contentPadding: EdgeInsets.only(
              top: 12, bottom: bottomPaddingToError, left: 8.0, right: 8.0),
          isDense: true,
          errorStyle: TextStyle(
            color: AppTheme.colors.red,
            fontSize: 12.0,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.normal,
            letterSpacing: 1.2,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.colors.powderBlue),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.colors.powderBlue),
          ),
        ),
        onSaved: widget.onSaved,
        validator: widget.validator,

      ),
    );
  }
}
