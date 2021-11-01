import 'package:flutter/material.dart';
import 'package:optyma_app/domain/templates/template.dart';

class TemplateCard extends StatelessWidget {
  final Template template;

  const TemplateCard({
    Key? key, 
    required this.template
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, 'template-form', arguments: template);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(template.expression.getOrCrash()),
        ),
      )
      
    );
  }
}