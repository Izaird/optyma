import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/cubit/logro/logro_cubit.dart';
import 'package:optyma_app/pages/admin/logro/add_logro_form.dart';
import 'package:optyma_app/repository/cloud_firestore_repository.dart';


class AddLogroPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider<LogroCubit>(  
          create: (_) => LogroCubit(RepositoryProvider.of<CloudFirestoreRepository>(context)),
          child: AddLogroForm(),
        ),
      ),
    );
  }
}