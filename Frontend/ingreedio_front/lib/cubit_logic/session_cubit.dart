import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:ingreedio_front/cubit_logic/session_data.dart';

class SessionCubit extends HydratedCubit<SessionData>
{
  void clearData(BuildContext context)
  {
    emit(SessionData.empty());
    while(Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }
  SessionCubit(super.state);
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