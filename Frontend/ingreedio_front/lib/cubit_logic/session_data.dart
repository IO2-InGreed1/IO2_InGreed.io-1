import 'package:dart_mappable/dart_mappable.dart';
import 'package:ingreedio_front/logic/admins.dart';
import 'package:ingreedio_front/logic/users.dart';
part 'session_data.mapper.dart';
@MappableClass()
class SessionData with SessionDataMappable
{
  SessionData.empty():userToken="";
  @MappableConstructor()
  SessionData.fromAllData({required this.userToken,required this.currentClient
  ,required this.currentProducer,
  required this.currentAdmin, required this.currentModerator});
  void fillWithData(SessionData data)
  {
    userToken=data.userToken;
    currentAdmin=data.currentAdmin;
    currentClient=data.currentClient;
    currentProducer=data.currentProducer;
    currentModerator=data.currentModerator;
  }
  String userToken;
  Client? currentClient;
  Producer? currentProducer;
  Moderator? currentModerator;
  Admin? currentAdmin;
}