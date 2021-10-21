import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/application/users/user_wathcer/user_watcher_bloc.dart';
import 'package:optyma_app/presentation/users/users_overview/widgets/user_card_widget.dart';

import 'critical_failure_display_widget.dart';


class UsersOverviewBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserWatcherBloc,UserWatcherState>(
      builder: (context,state){
        return state.map(
          initial: (_) => Container(), 
          loadInProgress: (_) => const Center(
            child: CircularProgressIndicator(),
          ), 
          loadSuccess: (state) {
            return ListView.builder(
              itemBuilder: (context, index){
                final user = state.users[index];
                return UserCard(user: user);
              },
              itemCount: state.users.length,
            );
          }, 
          loadFailure: (state){
            return CriticalFailureDisplay(
              failure: state.userFailure,
            );
          }
        );
      },
    );
    ;
  }
}