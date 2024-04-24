import 'package:dart_mappable/dart_mappable.dart';
part 'session_data.mapper.dart';
@MappableClass()
class SessionData with SessionDataMappable
{
  @MappableConstructor()
  SessionData.fromAllData({required this.userToken});
  String userToken;
}