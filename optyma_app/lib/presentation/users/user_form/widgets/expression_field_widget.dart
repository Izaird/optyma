import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:optyma_app/application/templates/template_form/template_form_bloc.dart';

class ExpressionField extends HookWidget{
  @override
  Widget build(BuildContext context) {
    final textEditingController = useTextEditingController();
    final textEditingController2 = useTextEditingController();
    final textEditingController3 = useTextEditingController();
    final textEditingController4 = useTextEditingController();
    return BlocListener<TemplateFormBloc, TemplateFormState>(
      listenWhen: (p, c) => p.isEditing != c.isEditing,
      listener: (context, state){
        textEditingController.text = state.template.expression.getOrCrash();
        textEditingController2.text = state.template.valuesEasy.getOrCrash();
        textEditingController3.text = state.template.valuesMedium.getOrCrash();
        textEditingController4.text = state.template.valuesHard.getOrCrash();
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(  
              controller: textEditingController,
              decoration: const InputDecoration(
                labelText: 'Expresion',
                counterText: ''
              ),
              maxLines: null,
              onChanged: (value) => BlocProvider.of<TemplateFormBloc>(context)
                .add(TemplateFormEvent.expressionChanged(value)),
              validator: (_) => BlocProvider.of<TemplateFormBloc>(context)
                .state
                .template
                .expression
                .value
                .fold(
                  (f) => f.maybeMap(
                    invalidExpression: (f) => 'Expresion no es valida',
                    empty: (f) => 'Este campo no puede estar vacio',
                    orElse: () => null,
                  ), 
                  (r) => null
                ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(  
              controller: textEditingController2,
              decoration: const InputDecoration(
                labelText: 'Valores Fácil',
                counterText: ''
              ),
              maxLines: null,
              onChanged: (value) => BlocProvider.of<TemplateFormBloc>(context)
                .add(TemplateFormEvent.valuesEasyChanged(value)),
              validator: (_) => BlocProvider.of<TemplateFormBloc>(context)
                .state
                .template
                .expression
                .value
                .fold(
                  (f) => f.maybeMap(
                    invalidExpression: (f) => 'Valores no son validos',
                    empty: (f) => 'Este campo no puede estar vacio',
                    orElse: () => null,
                  ), 
                  (r) => null
                ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(  
              controller: textEditingController3,
              decoration: const InputDecoration(
                labelText: 'Valores Medio',
                counterText: ''
              ),
              maxLines: null,
              onChanged: (value) => BlocProvider.of<TemplateFormBloc>(context)
                .add(TemplateFormEvent.valuesMediumChanged(value)),
              validator: (_) => BlocProvider.of<TemplateFormBloc>(context)
                .state
                .template
                .expression
                .value
                .fold(
                  (f) => f.maybeMap(
                    invalidExpression: (f) => 'Valores no son validos',
                    empty: (f) => 'Este campo no puede estar vacio',
                    orElse: () => null,
                  ), 
                  (r) => null
                ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(  
              controller: textEditingController4,
              decoration: const InputDecoration(
                labelText: 'Valores Difícil',
                counterText: ''
              ),
              maxLines: null,
              onChanged: (value) => BlocProvider.of<TemplateFormBloc>(context)
                .add(TemplateFormEvent.valuesHardChanged(value)),
              validator: (_) => BlocProvider.of<TemplateFormBloc>(context)
                .state
                .template
                .expression
                .value
                .fold(
                  (f) => f.maybeMap(
                    invalidExpression: (f) => 'Valores no son validos',
                    empty: (f) => 'Este campo no puede estar vacio',
                    orElse: () => null,
                  ), 
                  (r) => null
                ),
            ),
          ),
          ], 
      ),

    );
  }

}