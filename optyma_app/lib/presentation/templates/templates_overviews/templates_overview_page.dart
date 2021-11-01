import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/application/templates/template_watcher/template_watcher_bloc.dart';
import 'package:optyma_app/injection.dart';
import 'package:optyma_app/presentation/templates/template_form/widgets/templates_overview_body_widget.dart';


class TemplatesOverviewPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TemplateWatcherBloc>()
      ..add(const TemplateWatcherEvent.watchAllStarted()),
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
    );
  }
}