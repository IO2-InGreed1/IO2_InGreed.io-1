import 'package:ingreedio_front/database_mockup.dart';
import 'package:ingreedio_front/products.dart';
import 'users.dart';
abstract class IModerator
{
  List<Opinion> lookAtReports(Product product)
  {
    return DatabaseWrapper.instance.lookAtReports(product);
  }
  List<Opinion> searchInvalidOpinions()
  {
    return DatabaseWrapper.instance.searchInvalidOpinions();
  }
  void deleteOpinion(Opinion opinion)
  {
    DatabaseWrapper.instance.deleteOpinion(opinion);
  }
  User searchAdviser(Opinion opinion)
  {
    return DatabaseWrapper.instance.searchAdviser(opinion);
  }
}
class Moderator extends IModerator
{
  Moderator.fromAllData({required this.moderatorNumber,required this.editedOpinionList});
  int moderatorNumber;
  List<Opinion> editedOpinionList;
  void clearEditedOpinionList()
  {
    DatabaseWrapper.instance.clearEditedOpinionList(moderatorNumber);
  }
  void editionHistory(Opinion opinion)
  {
    //TODO: this
    throw Exception("not implemented");
  }
}
class Admin extends IModerator with IProducer
{
  Admin.fromAllData({required this.controlPanel});
  ControlPanel controlPanel;
  void getControlPanel()
  {
    //TODO: this
    throw Exception("not implemented");
  }
}
class ControlPanel
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