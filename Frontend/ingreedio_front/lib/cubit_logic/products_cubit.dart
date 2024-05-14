import 'package:flutter/material.dart';
import 'package:ingreedio_front/cubit_logic/list_cubit.dart';
import 'package:ingreedio_front/cubit_logic/session_cubit.dart';
import 'package:ingreedio_front/database/databse.dart';
import 'package:ingreedio_front/logic/filters.dart';
import 'package:ingreedio_front/logic/users.dart';
import '../logic/products.dart';
class ProductCubit extends ListCubit<Product>
{
  ProductCubit():super.empty();
  
  @override
  Filter<Product> lastFilter=ProductFilter();
  
  @override
  Future<ListData<Product>> getItems(int from, int to, Filter<Product> filter, BuildContext context) async {
    SessionCubit sessionCubit=SessionCubit.fromContext(context);
    return sessionCubit.database.productDatabse.filterProducts(from, to, filter as ProductFilter);
  }
  Future<bool> addProduct(Product product,BuildContext context) async
  {
    SessionCubit sessionCubit=SessionCubit.fromContext(context);
    return await sessionCubit.database.productDatabse.addProduct(product);
  }
  Future<bool> removeProduct(Product product,BuildContext context) async
  {
    SessionCubit sessionCubit=SessionCubit.fromContext(context);
    return await sessionCubit.database.productDatabse.removeProduct(product);
  }
  Future<bool> editProduct(Product product,Product editedProduct,BuildContext context) async
  {
    SessionCubit sessionCubit=SessionCubit.fromContext(context);
    return await sessionCubit.database.productDatabse.editProduct(product,editedProduct);
  }
}
class FavouriteProductsCubit extends ListCubit<Product>
{
  @override
  Filter<Product> lastFilter=ProductFilter();
  Client? client;
  FavouriteProductsCubit.empty() : super.empty();

  @override
  Future<ListData<Product>> getItems(int from, int to, Filter<Product> filter, BuildContext context) async {
    client ??= SessionCubit.fromContext(context).state.currentClient;
    if(client==null) throw Exception("client not logged in");
    return filterProducts(client!.favoriteProducts, from, to, filter);
  }
  
}
ListData<Product> filterProducts(List<Product> products,int from,int to,Filter<Product> filter)
{    
  if(filter is! ProductFilter) throw Exception("Wrong filter?");
  var pom= products.where((element) 
    {
      for(int i=0;i<element.ingredients.length;i++)
      {
        if(filter.allergens.contains(element.ingredients[i])) return false;
      }
      return true;
    }
    ).where((element) {
      if(filter.preference.isEmpty) return true;
      for(int i=0;i<filter.preference.length;i++)
      {
        if(!element.ingredients.contains(filter.preference[i])) return false;
      }
      return true;
    }).where((element) {
      return element.name.contains(filter.nameFilter);
    }).where((element) {
      if(filter.producer==null) return true;
      return filter.producer==element.producer;
      }).toList();
  List<Product> odp=List.empty(growable: true);
  for(int i=from;i<to;i++)
  {
    if(pom.length<=i) break;
    odp.add(pom[i]);
  }
  return ListData(odp,pom.length);
}
