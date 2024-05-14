import 'package:flutter/material.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/creators/preference_creator.dart';
import 'package:ingreedio_front/cubit_logic/cubit_consumer.dart';
import 'package:ingreedio_front/cubit_logic/preference_cubit.dart';
import 'package:ingreedio_front/cubit_logic/session_cubit.dart';
import 'package:ingreedio_front/logic/users.dart';
import 'package:ingreedio_front/ui/common_ui_elements.dart';

class PreferenceMenager extends CubitConsumer<Preference> {
  PreferenceMenager({super.key}):super(child: (context,preferences)
  {
    if(preferences==null) return const LoadingWidget();
    return ListView(
      children: preferences.map<Widget>((e) => 
        Row(
          children: [
            Text(e.name),
            TextButton(onPressed: ()
            {
              PreferenceCubit.fromContext(context).removePreference(context,e);
            }, child:const Text("Delete preference")),
            DialogEditButton<Preference>(creator: 
        PreferenceCreator(
        reference:ItemWrapper(e),
        ), 
        onFinished: (value)
        {
            value.client=SessionCubit.fromContext(context).state.currentClient!;
            PreferenceCubit.fromContext(context).editPreference(context,e,value);
        }, 
        onClicked: () {
          return e.clone();
        },
        child:const Text("edit preference"))
          
          ],
        )
      ).toList()..add(DialogButton<Preference>(
        creator: PreferenceCreator(
        reference:ItemWrapper(Preference.forClient(SessionCubit.fromContext(context).state.currentClient!),),
        ), 
        onFinished: (value)
        {
            PreferenceCubit.fromContext(context).addPreference(context,value);
        }, 
        child:const Text("add new preference")))
    );
  });
}