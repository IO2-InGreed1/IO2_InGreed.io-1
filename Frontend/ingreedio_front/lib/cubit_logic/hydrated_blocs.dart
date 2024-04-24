import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:ingreedio_front/cubit_logic/session_data.dart';

class SessionCubit extends HydratedCubit<SessionData>
{

  SessionCubit(super.state);
  
  @override
  SessionData? fromJson(Map<String, dynamic> json) {
    return SessionDataMapper.fromMap(json);
  }
  
  @override
  Map<String, dynamic>? toJson(SessionData state) {
    return state.toMap();
  }
  
}