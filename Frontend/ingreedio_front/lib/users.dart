import 'package:flutter/material.dart';
import 'package:ingreedio_front/assets.dart';
import 'package:ingreedio_front/products.dart';
import 'package:ingreedio_front/ui/client_widget.dart';

mixin class IProducer
{
  void promoteProduct(Product product,DateTime date)
  {
    //TODO: this
    throw Exception("not implemented");
  }
  void addProduct(Product product)
  {
    //TODO: this
    throw Exception("not implemented");
  }
  void removeProduct(Product product)
  {
    //TODO: this
    throw Exception("not implemented");
  }
}
abstract class User
{
  User.fromAllData({
    required this.id,
    required this.isBlocked,
    required this.mail,
    required this.password,
    required this.username
  });
  int id;
  String mail,password,username;
  bool isBlocked;
  void logIn()
  {
    //TODO: this
    throw Exception("not implemented");
  }
  void register()
  {
    //TODO: this
    throw Exception("not implemented");
  }
}
class Producer extends IProducer
{
  String companyName,nip,representativeName,representativeSurname,telephoneNumber;
  Producer.fromAllData({
    required this.companyName,
    required this.nip,
    required this.representativeName,
    required this.representativeSurname,
    required this.telephoneNumber,
  });
}
class Client extends User
{
  Client.fromAllData({required super.id,
  required super.isBlocked, 
  required super.mail, 
  required super.password, 
  required super.username,
  required this.favoriteProducts}) : super.fromAllData();
  Client.empty():favoriteProducts=[],super.fromAllData(id: 0, isBlocked: false, mail: "mail", password: "password", username: "username");
  List<Product> favoriteProducts;
  Widget get image=> Assets.placeholderImage;
  Widget get clientProfileWidget=>ClientProfileWidget(client: this,);
  Widget get clientWidget=>ClientWidget(client: this,);
  void findProducts(List<Ingredient> ingredients)
  {
    //TODO: this
    throw Exception("not implemented");
  }
  void removeMyOpinion(Opinion opinion)
  {
    //TODO: this
    throw Exception("not implemented");
  }
  void removePreferance(Preference preference)
  {
    //TODO: this
    throw Exception("not implemented");
  }
}
class Preference
{
  int id;
  String name;
  Client client;
  List<Ingredient> allergens;
  List<Ingredient> prefered;
  bool isActive;
  Preference.fromAllData({
    required this.allergens,
    required this.id,
    required this.isActive,
    required this.name,
    required this.prefered,
    required this.client
  });
  void addAllergen(Ingredient ingredient)
  {
    //TODO: this 
    throw Exception("not implemented");
  }
  void addprefered(Ingredient ingredient)
  {
    //TODO: this 
    throw Exception("not implemented");
  }
  void removeAllergen(Ingredient ingredient)
  {
    //TODO: this 
    throw Exception("not implemented");
  }
  void removePrefered(Ingredient ingredient)
  {
    //TODO: this 
    throw Exception("not implemented");
  }
  void changeActivity()
  {
    //TODO: this 
    throw Exception("not implemented");
  }
}