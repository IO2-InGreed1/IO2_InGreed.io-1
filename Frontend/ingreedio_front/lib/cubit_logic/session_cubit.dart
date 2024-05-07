import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:ingreedio_front/cubit_logic/session_data.dart';
import 'package:ingreedio_front/database/database_mockup.dart';
import 'package:ingreedio_front/database/databse.dart';
import 'package:ingreedio_front/database/real_database.dart';

class SessionCubit extends HydratedCubit<SessionData>
{
  
  late Database database;
  void reset()
  {
    emit(SessionData.empty());
  }
  SessionCubit(super.state)
  {
    database=MockupDatabase.filled();//..ingredientDatabase=RealIngredientDatabase(this);
  }
  void setData(SessionData data)
  {
    emit(data);
  }
  static SessionCubit fromContext(BuildContext context)
  {
    return context.read<SessionCubit>();
  }
  @override
  SessionData? fromJson(Map<String, dynamic> json) {
    return SessionDataMapper.fromMap(json);
  }
  
  @override
  Map<String, dynamic>? toJson(SessionData state) {
    return state.toMap();
  }
  
}