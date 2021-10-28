import 'package:another_flushbar/flushbar_helper.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:optyma_app/application/users/user_form/user_form_bloc.dart';
import 'package:optyma_app/domain/users/user.dart';
import 'package:optyma_app/injection.dart';
import 'package:optyma_app/presentation/users/user_form/widgets/admin_field_widget.dart';


class UserFormPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final editedUser = ModalRoute.of(context)!.settings.arguments as User;


    return BlocProvider(
      create: (context) => getIt<UserFormBloc>()
        ..add(UserFormEvent.initialized(optionOf(editedUser))),
      child: BlocConsumer<UserFormBloc, UserFormState>(  
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
                      insufficientPermission: (_) =>
                          'Permisos innecesarios ❌',
                      unableToUpdate: (_) =>
                          "No se pudo actualizar el usuario.",
                      unexpected: (_) =>
                          'Error inesperado.',
                    ),
                  ).show(context);
                },
                (_) {
                  Navigator.pop(context);
                },
              );
            },
          );
        },
        buildWhen: (p, c) => p.isSaving != p.isSaving,
        builder: (context, state){
          return Stack(
            children: [
              const UserFormPageScaffold(),
              SavingInProgressOverlay(isSaving: state.isSaving)
            ],
          );
        },
      ),
      
    );

  }
}


class SavingInProgressOverlay extends StatelessWidget {
  final bool isSaving;

  const SavingInProgressOverlay({
    Key? key,
    required this.isSaving,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isSaving,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        color: isSaving ? Colors.black.withOpacity(0.8) : Colors.transparent,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Visibility(
          visible: isSaving,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const CircularProgressIndicator(),
              const SizedBox(height: 8),
              Text(
                'Guardando',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class UserFormPageScaffold extends StatelessWidget {
  const UserFormPageScaffold({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  
        title: const Text('Editando usuario'),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<UserFormBloc>(context).add(
                const UserFormEvent.saved()
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

      body: BlocBuilder<UserFormBloc, UserFormState>( 
        buildWhen: (p, c) => p.showErrorMessages != c.showErrorMessages,
        builder: (context, state){
          return Form(
            child: Column(  
              children: [
                AdminField()
              ],
            )
          );
        },
      ),
    );
  }
}