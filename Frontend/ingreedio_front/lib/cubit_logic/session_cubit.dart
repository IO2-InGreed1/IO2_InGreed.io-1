import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:ingreedio_front/cubit_logic/session_data.dart';
import 'package:ingreedio_front/database/database_mockup.dart';
import 'package:ingreedio_front/database/databse.dart';
import 'package:ingreedio_front/database/real_database.dart';
import 'package:ingreedio_front/logic/products.dart';
import 'package:ingreedio_front/logic/users.dart';

class SessionCubit extends HydratedCubit<SessionData>
{
  void loginUser(String email,String password) async
  {
    SessionData? data=await database.loginUser(email, password);
    if(data==null) return;
    emit(data);
  }
  void refreshUser() async
  {
    User? user=await database.userDatabase.loadUser(state.userToken);
    if(state.currentUser==null) 
    {
      reset();
    }
    else 
    {
      emit(SessionData.empty()..fillWithData(state)..currentUser=user);
    }
  }
  void setFavouriteProduct(Product product, bool favourite)
  {
    if(state.currentClient!=null)
    {
      database.userDatabase.setFavouriteProduct(state.currentClient!, product, favourite);
      if(!favourite) 
      {
        state.currentClient!.favoriteProducts.remove(product);
      }
      else 
      {
        if(!state.currentClient!.favoriteProducts.contains(product)) state.currentClient!.favoriteProducts.add(product);
      }
    }
  }
  late Database database;
  void reset()
  {
    emit(SessionData.empty());
  }
  SessionCubit(super.state)
  {
    database=RealDatabase(this);
    //database=MockupDatabase.filled();
  }
  void setData(SessionData data)
  {
    emit(data);
  }
  static SessionCubit fromContext(BuildContext context)
  {
    return context.read<SessionCubit>();
  }
  @override
  SessionData? fromJson(Map<String, dynamic> json) {
    var value= SessionDataMapper.fromMap(json);
    try
    {
      database.userDatabase.loadUser(value.userToken);
    }
    catch(e)
    {
      return null;
    }
    return value;
  }
  
  @override
  Map<String, dynamic>? toJson(SessionData state) {
    return state.toMap();
  }
  
}