import 'package:flutter/material.dart';
import 'package:ingreedio_front/assets.dart';
import 'package:ingreedio_front/logic/products.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:ingreedio_front/ui/widgets/admin_widget.dart';
import 'package:ingreedio_front/ui/widgets/moderator_widget.dart';
import 'users.dart';
part 'admins.mapper.dart';
 /* abstract class IModerator
{

  User searchAdviser(Opinion opinion)
  {
    return opinion.author;
  }
}      */
@MappableClass(discriminatorKey: "Type",discriminatorValue: "Moderator")
class Moderator extends User with ModeratorMappable
{
  @MappableConstructor()
  Moderator.fromAllData({required super.id,
    required super.isBlocked,
    required super.mail,
    super.iconURL,
    required super.password,
    required super.username,
    required this.moderatorNumber,
    required this.editedOpinionList,}): super.fromAllData();
  int moderatorNumber;
  List<Opinion> editedOpinionList;
  @override
  Widget get image=> Assets.placeholderImage;
  @override
  Widget get userProfileWidget=>ModeratorProfileWidget(moderator: this,);
  @override
  Widget get userWidget=>ModeratorWidget(moderator: this,);
  @override 
  bool operator==(Object other)
  {
    if(other is! Moderator) return false;
    return other.isBlocked==isBlocked&&other.id==id&&other.username==username&&other.mail==mail;
  }
  
  @override
  int get hashCode => isBlocked.hashCode+username.hashCode+mail.hashCode;
  
}
@MappableClass(discriminatorKey: "Type",discriminatorValue: "Admin")
class Admin extends User with AdminMappable
{
  @MappableConstructor()
  Admin.fromAllData({
    required super.id,
    required super.isBlocked,
    super.iconURL,
    required super.mail,
    required super.password,
    required super.username,
    required this.controlPanel,
  }) : super.fromAllData();
  ControlPanel controlPanel;
  @override
  Widget get userWidget=>AdminWidget(admin: this,);
  @override 
  bool operator==(Object other)
  {
    if(other is! Admin) return false;
    return other.isBlocked==isBlocked&&other.id==id&&other.username==username&&other.mail==mail;
  }
  
  @override
  int get hashCode => isBlocked.hashCode+username.hashCode+mail.hashCode;
  
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