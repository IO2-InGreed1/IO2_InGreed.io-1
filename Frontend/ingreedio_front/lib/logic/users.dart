import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:ingreedio_front/assets.dart';
import 'package:ingreedio_front/logic/admins.dart';
import 'package:ingreedio_front/logic/products.dart';
import 'package:ingreedio_front/ui/screens/producer_screen.dart';
import 'package:ingreedio_front/ui/widgets/client_widget.dart';
import 'package:ingreedio_front/ui/widgets/user_widget.dart';
part 'users.mapper.dart';
@MappableClass(discriminatorKey: "Type",discriminatorValue: "User", includeSubClasses: [Admin,Moderator])
abstract class User with UserMappable
{
  @override 
  bool operator==(Object other)
  {
    if(other is! User) return false;
    return id==other.id&&isBlocked==other.isBlocked&&mail==other.mail&&password==other.password&&username==other.username;
  }
@MappableConstructor()
  User.fromAllData({
    required this.id,
    required this.isBlocked,
    required this.mail,
    required this.password,
    required this.username
  });
  int id;
  String mail,username;
  String? password;
  bool isBlocked;
  Widget get image=> Assets.placeholderImage;
  Widget get userProfileWidget=>UserProfileWidget(user:this);
  Widget get userWidget;
  
  @override
  int get hashCode => id+mail.hashCode*username.hashCode;
  
}
@MappableClass(discriminatorKey: "Type",discriminatorValue: "Producer")
class Producer extends User with ProducerMappable
{
  String companyName,nip,representativeName,representativeSurname,telephoneNumber;
 @MappableConstructor()
  Producer.fromAllData({
    required this.companyName,
    required this.nip,
    required this.representativeName,
    required this.representativeSurname,
    required this.telephoneNumber,
    required super.id,
    required super.isBlocked,
    required super.mail,
    required super.password,required super.username
  }) : super.fromAllData();
  @override 
  bool operator==(Object other)
  {
    if(other is! Producer) return false;
    return companyName==other.companyName&&nip==other.nip&&representativeName==other.representativeName&&representativeSurname==other.representativeSurname&&telephoneNumber==other.telephoneNumber;
  }
  
  @override
  int get hashCode => companyName.hashCode+nip.hashCode+representativeName.hashCode+representativeSurname.hashCode*telephoneNumber.hashCode;
  
  
  @override
  Widget get userWidget => ProducerScreen(producer: this);
  
}
@MappableClass(discriminatorKey: "Type",discriminatorValue: "Client")
class Client extends User with ClientMappable
{
 @MappableConstructor()
  Client.fromAllData({required super.id,
  required super.isBlocked, 
  required super.mail, 
  required super.password, 
  required super.username,
  required this.favoriteProducts}) : super.fromAllData();
  Client.empty():favoriteProducts=[],super.fromAllData(id: 0, isBlocked: false, mail: "mail", password: "password", username: "username");
  List<Product> favoriteProducts;
  @override
  Widget get userWidget=>ClientWidget(client: this,);
  @override 
  bool operator==(Object other)
  {
    if(other is! Client) return false;
    return other.isBlocked==isBlocked&&other.id==id&&other.username==username&&other.mail==mail;
  }
  
  @override
  int get hashCode => isBlocked.hashCode+username.hashCode+mail.hashCode;
  
}
class Preference
{
  int id;
  String name="";
  Client client;
  List<Ingredient> allergens=List.empty(growable: true);
  List<Ingredient> prefered=List.empty(growable: true);
  Category? category;
  Preference.fromAllData({
    required this.category,
    required this.allergens,
    required this.id,
    required this.name,
    required this.prefered,
    required this.client
  });
  Preference clone()
  {
    return Preference.fromAllData(allergens:copyList(allergens), id: id, name: name, prefered: copyList(prefered), client: client,category: category);
  }
  Preference.forClient(Client c):id=0,client=c;
}
List<T> copyList<T>(List<T> list)
{
  List<T> odp=List.empty(growable: true);
  for(int i=0;i<list.length;i++) {
    odp.add(list[i]);
  }
  return odp;
}