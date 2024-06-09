import 'dart:core';
import 'package:ingreedio_front/cubit_logic/session_data.dart';
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
  ProductDatabse get productDatabase;
  UserDatabse get userDatabase;
  IngredientDatabase get ingredientDatabase;
  OpinionDatabase get opinionDatabase;
  LoginDatabase get loginDatabase;
  Future<bool> removeOpinion(Opinion opinion)
  {
    return opinionDatabase.removeOpinion(opinion);
  }
  void clearEditedOpinionList(int moderatorNumber);
  Future<SessionData?> loginUser(String email,String password) async
  {
    String? data=await loginDatabase.login(email, password);
    if(data==null) return null;
    User? user=await userDatabase.loadUser(data);
    if(user==null) return null;
    SessionData sessionData=SessionData.empty()..userToken=data..currentUser=user;
    return sessionData;
  }
}
abstract class ProductDatabse
{
  SessionCubit get cubit=>throw Exception("not implemented");
  Future<bool> addProduct(Product product);
  Future<bool> removeProduct(Product product);
  Future<bool> setProductReportState(Product product,{bool state=false});
  Future<ListData<Product>> filterReportedProducts(int from,int to,Filter<Product> filter);
  Future<bool> editProduct(Product product,Product editedProduct);
  Future<ListData<Product>> filterProducts(int from,int to,ProductFilter filter);
  Future<bool> addProducer(Producer producer);
  Future<bool> removeProducer(Producer producer);
}
abstract class UserDatabse
{
  Future<User?> loadUser(String token);
  SessionCubit get cubit=>throw Exception("not implemented");
  //Future<bool> addClient(Client client);
  //Future<bool> removeClient(Client client);
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
  //Future<List<Opinion>> getClientOpinions(Client client);
  //Future<List<Opinion>> getProductOpinions(Product product);
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

abstract class LoginDatabase
{
  SessionCubit get cubit=>throw Exception("not implemented");
  Future<String?> register(String username,String email,String password,UserRole userRole);
  Future<String?> login(String email,String password);
}
