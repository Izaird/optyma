import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/application/users/user_wathcer/user_watcher_bloc.dart';
import 'package:optyma_app/injection.dart';
import 'package:optyma_app/presentation/users/users_overview/widgets/admins_switch.dart';
import 'package:optyma_app/presentation/users/users_overview/widgets/users_overview_body.dart';


class UsersOverviewPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UserWatcherBloc>()
      ..add(const UserWatcherEvent.watchAllStarted()),
      child: Scaffold( 
        appBar: AppBar(
          title: const Text("Usuarios"),
          actions: [
            AdminsSwitch(),
          ],
        ),
        body: UsersOverviewBody(),
       ),
    );
  }
}