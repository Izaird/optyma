import 'package:flutter/material.dart';

// *  textInputType - The type of information for which to optimize the text input control.
// *  hintText - Text that suggests what sort of input the field accepts.
// *  prefixIcon - Pass Icon if required
// *  defaultText - If there is predefined value is there for a text field
// *  obscureText - Is Password field?
// *  actionKeyboard - Keyboard action eg. next, done, search, etc
class DropDownWidget extends StatefulWidget {

  final String hintText;
  final String defaultText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final List<String> items;
  final String intialValue;


  const DropDownWidget({
    this.intialValue,
    this.hintText,
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
    return DropdownButtonFormField(
      
      onChanged: (value){
        setState(() {
          
        });  
      },
      value: widget.intialValue,
      items: widget.items.map((valueItem){
        return DropdownMenuItem(
          value: valueItem,
          child: Text(valueItem),
        );
      }).toList(),
      validator: widget.validator,
      onSaved: widget.onSaved,
      decoration: InputDecoration(  
        hintText: widget.hintText,
      ),

    );
  }
}