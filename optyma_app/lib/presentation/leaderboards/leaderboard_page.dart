import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/application/leaderboard/leaderboard_bloc.dart';
import 'package:optyma_app/injection.dart';
import 'package:optyma_app/presentation/leaderboards/leaderboard_body.dart';


class LeaderbordsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LeaderboardBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Leaderboards'),
        ),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: LeaderbordsBody(),
        )
      ),
    );
  }
}