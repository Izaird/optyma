import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/application/users/user_wathcer/user_watcher_bloc.dart';
import 'package:optyma_app/injection.dart';
import 'package:optyma_app/presentation/users/widgets/users_body.dart';


class UsersPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UserWatcherBloc>(),
      child: UsersBody(),
    );
  }
}