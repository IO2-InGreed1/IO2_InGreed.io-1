import 'package:dart_mappable/dart_mappable.dart';
import 'package:ingreedio_front/database/databse.dart';
import '../database/database_mockup.dart';
part 'session_data.mapper.dart';
@MappableClass()
class SessionData with SessionDataMappable
{
  SessionData.empty():userToken="";
  @MappableConstructor()
  SessionData.fromAllData({required this.userToken});
  String userToken;
  Database database=MockupDatabase.filled();
}