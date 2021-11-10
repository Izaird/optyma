import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/application/templates/template_actor/bloc/template_actor_bloc.dart';
import 'package:optyma_app/application/templates/template_watcher/template_watcher_bloc.dart';
import 'package:optyma_app/injection.dart';
import 'package:optyma_app/presentation/templates/template_form/widgets/templates_overview_body_widget.dart';

class TemplatesOverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<TemplateWatcherBloc>()
            ..add(const TemplateWatcherEvent.watchAllStarted()),
        ),
        BlocProvider(
          create: (context) => getIt<TemplateActorBloc>(),
        ),
      ],
      child: BlocListener<TemplateActorBloc, TemplateActorState>(
        listener: (context, state) {
          state.maybeMap(
            deleteFailure: (state){
              FlushbarHelper.createError(
                duration: Duration(seconds: 5),
                message: state.templateFailure.map(
                  unexpected: (_) =>
                    'Ocurrio un error inesperado al intentar borra la plantilla', 
                  unableToUpdate: (_) =>
                    'Impossible error', 
                  noTemplates: (_) =>
                    'Impossible error', 
                  insufficientPermission: (_) =>
                    'Permisos insuficientes ❌', 
                )
              ).show(context);
            },
            orElse: (){}
          );
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Plantillas'),
          ),
          body: TemplatesOverviewBody(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, 'template-form');
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
