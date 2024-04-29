import 'dart:core';
import 'package:ingreedio_front/logic/filters.dart';
import 'package:ingreedio_front/logic/products.dart';
import 'package:ingreedio_front/logic/users.dart';
abstract class Database
{
  ProductDatabse get productDatabse;
  UserDatabse get userDatabse;
  IngredientDatabase get ingredientDatabase;
  OpinionDatabase get opinionDatabase;
  bool addClient(Client client)
  {
    return userDatabse.addClient(client);
  }
  bool removeClient(Client client)
  {
    return userDatabse.removeClient(client);
  }
  bool removeOpinion(Opinion opinion)
  {
    return opinionDatabase.removeOpinion(opinion);
  }
  List<Client> getAllClients()
  {
    return userDatabse.getAllClients();
  }
  List<Producer> getAllProducers()
  {
    return productDatabse.getAllProducers();
  }
  List<Ingredient> getAllIngredients()
  {
    return ingredientDatabase.getAllIngredients();
  }
  List<Opinion> getAllOpinions()
  {
    return opinionDatabase.getAllOpinions();
  }
  List<Product> getAllProducts()
  {
    return productDatabse.getAllProducts();
  }
  List<Opinion> getReportedOpinions(Product product)
  {
    return opinionDatabase.getReportedProductOpinions(product);
  }
  List<Opinion> searchInvalidOpinions();
  void clearEditedOpinionList(int moderatorNumber);
}
abstract class ProductDatabse
{
  bool addProduct(Product product);
  bool removeProduct(Product product);
  List<Product> getAllProducts();
  List<Product> filterProducts(int from,int to,ProductFilter filter);
  List<Producer> getAllProducers();
  bool addProducer(Producer producer);
  bool removeProducer(Producer producer);
}
abstract class UserDatabse
{
  bool addClient(Client client);
  bool removeClient(Client client);
  List<Client> getAllClients();
  List<Preference> getUserPreferences(Client client);
  bool addPreference(Preference preference);
  bool removePreference(Preference preference);
}
abstract class OpinionDatabase
{
  List<Opinion> getAllOpinions();
  bool addOpinion(Opinion opinion);
  bool removeOpinion(Opinion opinion);
  List<Opinion> getClientOpinions(Client client);
  List<Opinion> getProductOpinions(Product product);
  List<Opinion> getReportedOpinions();
  List<Opinion> getReportedProductOpinions(Product product);
  List<Opinion> getOpinionsFiltered(int from,int to,Product product,OpinionFilter filter);
}
abstract class IngredientDatabase
{
  List<Ingredient> getAllIngredients();
}
