import 'package:flutter/material.dart';

class DropdownIntToIntWidget extends StatefulWidget {

  final String hint;
  final FormFieldSetter onSaved;
  final List<int> items;
  final int intialValue;
  final String validatorErrorMessage;



  const DropdownIntToIntWidget({
    this.validatorErrorMessage,
    this.intialValue,
    this.hint,
    this.onSaved,
    @required this.items,
  });

  @override
  _DropdownIntToIntWidgetState createState() => _DropdownIntToIntWidgetState();
}

class _DropdownIntToIntWidgetState extends State<DropdownIntToIntWidget> {
  double bottomPaddingToError = 12;
  String aux;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      hint: Text(widget.hint),
      value: widget.intialValue,
      items: widget.items.map((valueItem){
        return DropdownMenuItem(
          value: valueItem,
          child: Text(valueItem.toString()),
        );
      }).toList(),
      
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