import 'package:dart_mappable/dart_mappable.dart';
import 'package:ingreedio_front/database/databse.dart';
import 'package:ingreedio_front/logic/users.dart';
import '../database/database_mockup.dart';
part 'session_data.mapper.dart';
@MappableClass()
class SessionData with SessionDataMappable
{
  SessionData.empty():userToken="";
  @MappableConstructor()
  SessionData.fromAllData({required this.userToken,required this.currentClient,required this.navigatorPath,required this.currentProducer});
  String userToken,navigatorPath="/";
  Database database=MockupDatabase.filled();
  Client? currentClient;
  Producer? currentProducer;
}