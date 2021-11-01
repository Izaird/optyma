import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/application/templates/template_watcher/template_watcher_bloc.dart';
import 'package:optyma_app/presentation/templates/templates_overviews/widgets/critical_failure_display_widget.dart';
import 'package:optyma_app/presentation/templates/templates_overviews/widgets/template_card_widget.dart';
class TemplatesOverviewBody extends StatelessWidget {
  const TemplatesOverviewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemplateWatcherBloc, TemplateWatcherState>(
      builder: (context, state){
        return state.map(
          initial: (_) => Container(), 
          loadInProgress: (_) => const Center(  
            child: CircularProgressIndicator(),
          ), 
          loadSuccess: (state){
            return ListView.builder(
              itemBuilder: (context, index){
                final template = state.templates[index];
                return TemplateCard(template: template);
              },
              itemCount: state.templates.length,
            );
          }, 
          loadFailure: (state){
            return CriticalFailureDisplay(
              failure: state.templateFailure
            );  
          }
        );
      },
    );
  }
}