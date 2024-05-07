import 'dart:core';
import 'package:ingreedio_front/cubit_logic/session_data.dart';
import 'package:ingreedio_front/logic/admins.dart';
import 'package:ingreedio_front/logic/filters.dart';
import 'package:ingreedio_front/logic/products.dart';
import 'package:ingreedio_front/logic/users.dart';
import '../cubit_logic/session_cubit.dart';
abstract class Database
{
  ProductDatabse get productDatabse;
  UserDatabse get userDatabse;
  IngredientDatabase get ingredientDatabase;
  OpinionDatabase get opinionDatabase;
  LoginDatabase get loginDatabase;
  Future<bool> addClient(Client client)
  {
    return userDatabse.addClient(client);
  }
  Future<bool> removeClient(Client client)
  {
    return userDatabse.removeClient(client);
  }
  Future<bool> removeOpinion(Opinion opinion)
  {
    return opinionDatabase.removeOpinion(opinion);
  }
  Future<List<Client>> getAllClients()
  {
    return userDatabse.getAllClients();
  }
  Future<List<Producer>> getAllProducers()
  {
    return productDatabse.getAllProducers();
  }

  Future<List<Opinion>> getAllOpinions()
  {
    return opinionDatabase.getAllOpinions();
  }
  Future<List<Product>> getAllProducts()
  {
    return productDatabse.getAllProducts();
  }
  Future<List<Opinion>> getReportedOpinions(Product product)
  {
    return opinionDatabase.getReportedProductOpinions(product);
  }
  Future<List<Opinion>> searchInvalidOpinions();
  void clearEditedOpinionList(int moderatorNumber);
}
abstract class ProductDatabse
{
  SessionCubit get cubit=>throw Exception("not implemented");
  Future<bool> addProduct(Product product);
  Future<bool> removeProduct(Product product);
  Future<bool> editProduct(Product product,Product editedProduct);
  Future<List<Product>> getAllProducts();
  Future<List<Product>> filterProducts(int from,int to,ProductFilter filter);
  Future<List<Producer>> getAllProducers();
  Future<bool> addProducer(Producer producer);
  Future<bool> removeProducer(Producer producer);
}
abstract class UserDatabse
{
  SessionCubit get cubit=>throw Exception("not implemented");
  Future<bool> addClient(Client client);
  Future<bool> removeClient(Client client);
  Future<List<Client>> getAllClients();
  Future<List<Preference>> getUserPreferences(Client client);
  Future<bool> setFavoutiteProduct(Client client,Product product,bool state);
  Future<bool> addPreference(Preference preference);
  Future<bool> editPreference(Preference oldPreference,Preference editedPreference);
  Future<bool> removePreference(Preference preference);
}
abstract class OpinionDatabase
{
  SessionCubit get cubit=>throw Exception("not implemented");
  Future<List<Opinion>> getAllOpinions();
  Future<bool> addOpinion(Opinion opinion);
  Future<bool> removeOpinion(Opinion opinion);
  Future<List<Opinion>> getClientOpinions(Client client);
  Future<List<Opinion>> getProductOpinions(Product product);
  Future<List<Opinion>> getReportedOpinions();
  Future<List<Opinion>> getReportedProductOpinions(Product product);
  Future<List<Opinion>> getOpinionsFiltered(int from,int to,Product product,OpinionFilter filter);
}
abstract class IngredientDatabase
{
  SessionCubit get cubit=>throw Exception("not implemented");
  Future<List<Ingredient>> getAllIngredients();
}
enum UserRole
{
  client,producer,moderator,admin
}
class LoginData
{
  String verificationToken;
  UserRole userRole;
  LoginData(this.userRole,this.verificationToken);
}
abstract class LoginDatabase
{
  SessionCubit get cubit=>throw Exception("not implemented");
  Future<LoginData?> register(String username,String email,String password,UserRole userRole);
  Future<LoginData?> login(String email,String password);
  Future<Client?> loadClient(String token);
  Future<Producer?> loadProducer(String token);
  Future<Admin?> loadAdmin(String token);
  Future<Moderator?> loadModerator(String token);
  Future<SessionData?> loginUser(String email,String password) async
  {
    LoginData? data=await login(email, password);
    if(data==null) return null;
    SessionData sessionData=SessionData.empty()..userToken=data.verificationToken;
    switch(data.userRole)
    {
      case UserRole.client:
        Client? client=await loadClient(data.verificationToken);
        if(client==null) throw Exception("invalid verification token?");
        sessionData.currentClient=client;
        break;
      case UserRole.producer:
        Producer? producer=await loadProducer(data.verificationToken);
        if(producer==null) throw Exception("invalid verification token?");
        sessionData.currentProducer=producer;
        break;
      case UserRole.moderator:
        Moderator? moderator=await loadModerator(data.verificationToken);
        if(moderator==null) throw Exception("invalid verification token?");
        sessionData.currentModerator=moderator;
        break;
      case UserRole.admin:
        Admin? admin=await loadAdmin(data.verificationToken);
        if(admin==null) throw Exception("invalid verification token?");
        sessionData.currentAdmin=admin;
        break;
    }
    return sessionData;
  }
}
