import 'package:ingreedio_front/logic/products.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'users.dart';
part 'package:ingreedio_front/logic/admins.mapper.dart';
abstract class IModerator
{
  User searchAdviser(Opinion opinion)
  {
    return opinion.author;
  }
}
@MappableClass()
class Moderator extends IModerator with ModeratorMappable
{
  @MappableConstructor()
  Moderator.fromAllData({required this.moderatorNumber,required this.editedOpinionList});
  int moderatorNumber;
  List<Opinion> editedOpinionList;
  void editionHistory(Opinion opinion)
  {
    //TODO: this
    throw Exception("not implemented");
  }
}
@MappableClass()
class Admin extends IModerator with IProducer,AdminMappable
{
  @MappableConstructor()
  Admin.fromAllData({required this.controlPanel});
  ControlPanel controlPanel;
  void getControlPanel()
  {
    //TODO: this
    throw Exception("not implemented");
  }
}
@MappableClass()
class ControlPanel with ControlPanelMappable
{
  void deleteUser(User user)
  {
    //TODO: this
    throw Exception("not implemented");
  }
  void blockUser(User user)
  {
    //TODO: this
    throw Exception("not implemented");
  }
  void unBlockUser(User user)
  {
    //TODO: this
    throw Exception("not implemented");
  }
  void addUser(User user)
  {
    //TODO: this
    throw Exception("not implemented");
  }
  void returnLogs()
  {
    //TODO: this
    throw Exception("not implemented");
  }
  void returnUserHistory(User user)
  {
    //TODO: this
    throw Exception("not implemented");
  }
  void giveRole(String role)
  {
    //TODO: this
    throw Exception("not implemented");
  }
  void degrade(User user)
  {
    //TODO: this
    throw Exception("not implemented");
  }
}