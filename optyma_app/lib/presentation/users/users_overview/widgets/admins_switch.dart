import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:optyma_app/application/users/user_wathcer/user_watcher_bloc.dart';

class AdminsSwitch extends HookWidget{
  @override
  Widget build(BuildContext context) {
    final toggleState = useState(true);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkResponse(  
        onTap: (){
          toggleState.value = !toggleState.value;
          BlocProvider.of<UserWatcherBloc>(context).add(
            toggleState.value 
              ? const UserWatcherEvent.watchAllStarted()
              : const UserWatcherEvent.watchAdminsStarted()
          );
        },
        child: AnimatedSwitcher(  
          duration: const Duration(milliseconds: 100),
          transitionBuilder: (child, animation) => ScaleTransition(
            scale: animation,
            child: child
          ),
          child: toggleState.value 
            ? const Icon(
              Icons.check_box_outline_blank,
              key: Key('outline'),
              ) 
            : const Icon(
              Icons.indeterminate_check_box,
              key: Key('indeterminate'),
              ),
        ),
      ),

    );
  }
}