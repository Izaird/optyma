import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:optyma_app/application/users/user_form/user_form_bloc.dart';

class AdminField extends HookWidget{
  @override
  Widget build(BuildContext context) {
    final adminState = useState(true);

    return BlocListener<UserFormBloc, UserFormState>(
      listenWhen: (p, c) => p.isEditing != c.isEditing,
      listener: (context, state){
        adminState.value = state.user.admin;
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            const Expanded(
              child: Text('Permisos de administrador')),
            InkResponse(
              onTap: (){
                adminState.value = !adminState.value;
                BlocProvider.of<UserFormBloc>(context).add(
                  UserFormEvent.isAdminChanged(isAdmin: adminState.value)  
                );

              },
              child: AnimatedSwitcher(  
                duration: const Duration(milliseconds: 100),
                transitionBuilder: (child, animation) => ScaleTransition(
                  scale: animation,
                  child: child,
                ),
                child: adminState.value 
                  ? const Icon(
                    FontAwesomeIcons.checkSquare,
                    key: Key('outline'),
                  ) 
                  : const Icon(
                    FontAwesomeIcons.square,
                    key: Key('indeterminate'),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}