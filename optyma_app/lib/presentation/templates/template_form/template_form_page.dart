import 'package:another_flushbar/flushbar_helper.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:optyma_app/application/templates/template_form/template_form_bloc.dart';
import 'package:optyma_app/domain/templates/template.dart';
import 'package:optyma_app/injection.dart';
import 'package:optyma_app/presentation/users/user_form/user_form_page.dart';
import 'package:optyma_app/presentation/users/user_form/widgets/expression_field_widget.dart';


class TemplateFormPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final editedTemplate = ModalRoute.of(context)!.settings.arguments as Template?;


    return BlocProvider(
      create: (context) => getIt<TemplateFormBloc>()
        ..add(TemplateFormEvent.initialized(optionOf(editedTemplate))),
      child: BlocConsumer<TemplateFormBloc, TemplateFormState>(


        listenWhen: (p, c) => 
          p.saveFailureOrSuccessOption != c.saveFailureOrSuccessOption,
        listener: (context, state) {
          state.saveFailureOrSuccessOption.fold(
            () {}, 
            (either) {
              either.fold(
                (failure) {
                  FlushbarHelper.createError(
                    message: failure.map(
                      unexpected: (_) => 
                        'Permisos innecesarios ❌', 
                      unableToUpdate: (_) =>
                        'No se pudo actualizar la plantilla', 
                      insufficientPermission: (_) =>
                        'Error inesperado.'
                    )
                  );
                }, 
                (_) => {
                  Navigator.pop(context),
                }
              );
            }
          );
        },


        buildWhen: (p, c) => p.isSaving != c.isSaving,
        builder: (context,state){
          return Stack(
            children: [
              const TemplateFormPageScaffold(),
              SavingInProgressOverlay(isSaving: state.isSaving)
            ],
          );
        },
      ),
    );
  }
}




class TemplateFormPageScaffold extends StatelessWidget {
  const TemplateFormPageScaffold({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  
        title: BlocBuilder<TemplateFormBloc, TemplateFormState>(
          buildWhen: (p, c) => p.isEditing != c.isEditing,
          builder: (context, state) {
            return Text(state.isEditing ? 'Editando plantilla' : 'Creando plantilla');
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<TemplateFormBloc>(context).add(
                const TemplateFormEvent.saved()
              );
            }, 
            icon: const Icon(FontAwesomeIcons.check)
          )
        ],
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.times),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: BlocBuilder<TemplateFormBloc, TemplateFormState>( 
        buildWhen: (p, c) => p.showErrorMessages != c.showErrorMessages,
        builder: (context, state){
          return Form(
            autovalidateMode: state.showErrorMessages 
              ? AutovalidateMode.always 
              : AutovalidateMode.disabled,
            child: Column(  
              children: [
                ExpressionField(),
              ],
            )
          );
        },
      ),
    );
  }
}