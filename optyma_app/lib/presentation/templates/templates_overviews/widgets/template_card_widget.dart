import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/application/templates/template_actor/bloc/template_actor_bloc.dart';
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
        onLongPress: (){
          final templateBloc = context.read<TemplateActorBloc>();
          _showDeletionDialog(context, templateBloc);
        },
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


  void _showDeletionDialog(BuildContext context, TemplateActorBloc templateActorBloc){
    showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          title: const Text('Plantilla seleccionada:'),
          content: Text(
            template.expression.getOrCrash(),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text('Cancelar')
            ),
            TextButton(
              onPressed: () {
                templateActorBloc.add(TemplateActorEvent.deleted(template));
                Navigator.pop(context);
              }, 
              child: const Text('Borrar')
            ),
          ],
        );
      }
    );
  }
}
