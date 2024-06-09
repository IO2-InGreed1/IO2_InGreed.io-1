import 'package:dart_mappable/dart_mappable.dart';
import 'package:ingreedio_front/logic/admins.dart';
import 'package:ingreedio_front/logic/users.dart';
part 'session_data.mapper.dart';
@MappableClass()
class SessionData with SessionDataMappable
{
  bool registerScreen=false;
  SessionData.empty():userToken="";
  @MappableConstructor()
  SessionData.fromAllData({required this.userToken,required this.currentUser});
  User? currentUser;
  void reset()
  {
    userToken="";
    currentUser=null;
  }
  void fillWithData(SessionData data)
  {
    userToken=data.userToken;
    currentUser=data.currentUser;
    registerScreen=data.registerScreen;
  }
  String userToken;
  Client? get currentClient
  {
    if(currentUser is Client) return currentUser as Client;
    return null;
  }
  Producer? get currentProducer
  {
    if(currentUser is Producer) return currentUser as Producer;
    return null;
  }
  Moderator? get currentModerator  
  {
    if(currentUser is Moderator) return currentUser as Moderator;
    return null;
  }
  Admin? get currentAdmin
{
    if(currentUser is Admin) return currentUser as Admin;
    return null;
  }
  bool get isLoggedIn
  {
    return currentAdmin!=null||currentClient!=null||currentModerator!=null||currentProducer!=null;
  }
}