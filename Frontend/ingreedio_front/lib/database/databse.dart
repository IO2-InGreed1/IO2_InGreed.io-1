import 'dart:core';
import 'package:ingreedio_front/cubit_logic/session_data.dart';
import 'package:ingreedio_front/logic/admins.dart';
import 'package:ingreedio_front/logic/filters.dart';
import 'package:ingreedio_front/logic/products.dart';
import 'package:ingreedio_front/logic/users.dart';
import '../cubit_logic/session_cubit.dart';
class ListData<T>
{
  List<T> list;
  int maxCount;
  ListData(this.list,this.maxCount);
}
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
  void clearEditedOpinionList(int moderatorNumber);
  Future<SessionData?> loginUser(String email,String password) async
  {
    LoginData? data=await loginDatabase.login(email, password);
    if(data==null) return null;
    SessionData sessionData=SessionData.empty()..userToken=data.verificationToken;
    switch(data.userRole)
    {
      case UserRole.client:
        Client? client=await userDatabse.loadClient(data.verificationToken);
        if(client==null) throw Exception("invalid verification token?");
        sessionData.currentClient=client;
        break;
      case UserRole.producer:
        Producer? producer=await userDatabse.loadProducer(data.verificationToken);
        if(producer==null) throw Exception("invalid verification token?");
        sessionData.currentProducer=producer;
        break;
      case UserRole.moderator:
        Moderator? moderator=await userDatabse.loadModerator(data.verificationToken);
        if(moderator==null) throw Exception("invalid verification token?");
        sessionData.currentModerator=moderator;
        break;
      case UserRole.admin:
        Admin? admin=await userDatabse.loadAdmin(data.verificationToken);
        if(admin==null) throw Exception("invalid verification token?");
        sessionData.currentAdmin=admin;
        break;
    }
    return sessionData;
  }
}
abstract class ProductDatabse
{
  SessionCubit get cubit=>throw Exception("not implemented");
  Future<bool> addProduct(Product product);
  Future<bool> removeProduct(Product product);
  Future<bool> editProduct(Product product,Product editedProduct);
  Future<ListData<Product>> filterProducts(int from,int to,ProductFilter filter);
  Future<bool> addProducer(Producer producer);
  Future<bool> removeProducer(Producer producer);
}
abstract class UserDatabse
{
  Future<Client?> loadClient(String token);
  Future<Producer?> loadProducer(String token);
  Future<Admin?> loadAdmin(String token);
  Future<Moderator?> loadModerator(String token);
  SessionCubit get cubit=>throw Exception("not implemented");
  Future<bool> addClient(Client client);
  Future<bool> removeClient(Client client);
  Future<List<Preference>> getUserPreferences(Client client);
  Future<bool> setFavouriteProduct(Client client,Product product,bool state);
  Future<bool> addPreference(Preference preference);
  Future<bool> editPreference(Preference oldPreference,Preference editedPreference);
  Future<bool> removePreference(Preference preference);
}
abstract class OpinionDatabase
{
  SessionCubit get cubit=>throw Exception("not implemented");
  Future<bool> addOpinion(Opinion opinion);
  Future<bool> removeOpinion(Opinion opinion);
  Future<List<Opinion>> getClientOpinions(Client client);
  Future<List<Opinion>> getProductOpinions(Product product);
  Future<ListData<Opinion>> getReportedFilteredOpinions(int from,int to,Filter<Opinion> filter);
  Future<ListData<Opinion>> getOpinionsFiltered(int from,int to,Product product,OpinionFilter filter);
  Future<void> setOpinionReport(Opinion opinion,{bool reportState=true});
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
}
