import 'package:flutter/material.dart';
import 'package:ingreedio_front/cubit_logic/list_cubit.dart';
import 'package:ingreedio_front/cubit_logic/session_cubit.dart';
import 'package:ingreedio_front/logic/filters.dart';
import '../logic/products.dart';
class ProductCubit extends ListCubit<Product>
{
  ProductCubit(super.initialState);
  ProductCubit.empty():this(null);
  
  @override
  Filter<Product> lastFilter=ProductFilter();
  
  @override
  Future<List<Product>> getItems(int from, int to, Filter<Product> filter, BuildContext context) async {
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
