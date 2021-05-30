import 'package:flutter/material.dart';
/// A convenience widget that makes a [DropdownButton] into a [FormField].
class DropdownStrToIntWidget extends StatefulWidget {

  final String hint;
  final FormFieldSetter onSaved;
  final List<String> items;
  final int intialValue;
  final String validatorErrorMessage;

  const DropdownStrToIntWidget({
    this.validatorErrorMessage,
    this.intialValue,
    this.hint,
    this.onSaved,
    @required this.items,
  });

  @override
  _DropdownStrToIntWidgetState createState() => _DropdownStrToIntWidgetState();
}

class _DropdownStrToIntWidgetState extends State<DropdownStrToIntWidget> {
  double bottomPaddingToError = 12;
  String aux;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      hint: Text(widget.hint),
      value: widget.intialValue,
      items: widget.items.asMap().entries.map((e) => 
      DropdownMenuItem(
        value: e.key,
        child: Text(e.value),
        )).toList(),
      onChanged: (value){
        setState(() {
          
        });  
      },
      validator: (value){
        if(value != null){
          return null;
        }else{
          return widget.validatorErrorMessage;
        }
      },
      onSaved: widget.onSaved,

    );
  }
}