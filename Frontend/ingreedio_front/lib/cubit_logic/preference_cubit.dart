import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ingreedio_front/cubit_logic/session_cubit.dart';
import 'package:ingreedio_front/database/databse.dart';
import 'package:ingreedio_front/logic/users.dart';

class PreferenceCubit extends Cubit<List<Preference>?>
{
  PreferenceCubit(super.initialState);
  PreferenceCubit.empty():super(null);
  static PreferenceCubit fromContext(BuildContext context)
  {
    return context.read<PreferenceCubit>();
  }
  void loadPreferences(BuildContext context,Client client)
  {
    Database database=SessionCubit.fromContext(context).database;
    database.userDatabase.getUserPreferences(client).then((value) => emit(value));
  }
  void addPreference(BuildContext context,Preference preference)
  {
    Database database=SessionCubit.fromContext(context).database;
    database.userDatabase.addPreference(preference).then((value)
    {
      if(state!=null&&value==true) 
      {
        emit([...state!,preference]);
      }
    });
  }
  void removePreference(BuildContext context,Preference preference)
  {
    Database database=SessionCubit.fromContext(context).database;
    database.userDatabase.removePreference(preference).then((value)
    {
      if(state!=null&&value==true) 
      {
        emit(List.from(state!..remove(preference)));
      }
    });
  }
  void editPreference(BuildContext context,Preference preference,Preference editedPreference)
  {
    Database database=SessionCubit.fromContext(context).database;
    database.userDatabase.editPreference(preference,editedPreference).then((value)
    {
      if(state!=null&&value==true) 
      {
        emit(List.from(state!..remove(preference)..add(editedPreference)));
      }
    });
  }
}