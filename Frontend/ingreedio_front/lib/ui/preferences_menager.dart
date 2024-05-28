import 'package:flutter/material.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/creators/preference_creator.dart';
import 'package:ingreedio_front/cubit_logic/cubit_consumer.dart';
import 'package:ingreedio_front/cubit_logic/preference_cubit.dart';
import 'package:ingreedio_front/cubit_logic/session_cubit.dart';
import 'package:ingreedio_front/logic/users.dart';
import 'package:ingreedio_front/ui/common_ui_elements.dart';
import 'package:ingreedio_front/ui/widgets/opinion_widget.dart';

class PreferenceMenager extends PreferenceConsumer {
  PreferenceMenager({super.key}):super(child: (context,preferences)
  {
    if(preferences==null) return const LoadingWidget();
    return ListView(
      children: [
        const Center(child: Text("Your preferences:",style: TextStyle(fontSize: 20),)),
        ...preferences.map<Widget>((e) => 
        SizedBox(
          height: 70,
          child: Center(
            child: StandardDecorator(
              width: 630,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (e.category != null) Icon(e.category!.icon),
                        OpinionText(text:e.name,maxLength: 40),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: TextButton(
                      onPressed: () {
                        PreferenceCubit.fromContext(context).removePreference(context, e);
                      },
                      child: const Text("Delete preference"),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: DialogEditButton<Preference>(
                      creator: PreferenceCreator(
                        reference: ItemWrapper(e),
                      ),
                      onFinished: (value) {
                        value.client = SessionCubit.fromContext(context).state.currentClient!;
                        PreferenceCubit.fromContext(context).editPreference(context, e, value);
                      },
                      onClicked: () {
                        return e.clone();
                      },
                      child: const Text("edit preference"),
                    ),
                  ),
                ],
              )
            ),
          ),
        )
      ).toList(),
      DialogButton<Preference>(
        creator: PreferenceCreator(
        reference:ItemWrapper(Preference.forClient(SessionCubit.fromContext(context).state.currentClient!),),
        ), 
        onFinished: (value)
        {
            PreferenceCubit.fromContext(context).addPreference(context,value);
        }, 
        child:const Text("add new preference"))
        ]
    );
  });
}