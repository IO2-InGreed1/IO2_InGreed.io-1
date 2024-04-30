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
  List<Product> getItems(int from, int to, Filter<Product> filter, BuildContext context) {
    SessionCubit sessionCubit=SessionCubit.fromContext(context);
    return sessionCubit.state.database.productDatabse.filterProducts(from, to, filter as ProductFilter);
  }
    bool addProduct(Product product,BuildContext context)
  {
    SessionCubit sessionCubit=SessionCubit.fromContext(context);
    return sessionCubit.state.database.productDatabse.addProduct(product);
  }
  bool removeProduct(Product product,BuildContext context)
  {
    SessionCubit sessionCubit=SessionCubit.fromContext(context);
    return sessionCubit.state.database.productDatabse.removeProduct(product);
  }
  bool editProduct(Product product,Product editedProduct,BuildContext context)
  {
    SessionCubit sessionCubit=SessionCubit.fromContext(context);
    return sessionCubit.state.database.productDatabse.editProduct(product,editedProduct);
  }
}
