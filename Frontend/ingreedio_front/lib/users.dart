import 'package:ingreedio_front/products.dart';

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
  required this.preferences,
  required this.favoriteProducts}) : super.fromAllData();
  List<Preference> preferences;
  List<Product> favoriteProducts;
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