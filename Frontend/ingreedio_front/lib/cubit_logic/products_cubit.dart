import 'package:flutter/material.dart';
import 'package:ingreedio_front/cubit_logic/session_cubit.dart';
import 'package:ingreedio_front/logic/filters.dart';

import '../logic/products.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
class ProductCubit extends Cubit<List<Product>?>
{
  Map<int,Product> products={};
  ProductFilter lastFilter=ProductFilter();
  ProductCubit(super.initialState)
  {
    if(state!= null)
    {
      for(int i=0;i<state!.length;i++)
      {
       products[i]=state![i];
     }
    }
  }
  ProductCubit.empty():this(null);
  Future<void> loadData(int from,int to,ProductFilter filter,BuildContext context) async
  {
    emit(null);
    if(!(filter==lastFilter))
    {
      products={};
      lastFilter=filter.clone();
    }
    List<Product> newProducts=List.empty(growable: true);
    for(int i=from;i<to;i++)
    {
      if(!products.containsKey(i))
      {
        var sessionCubit=SessionCubit.fromContext(context);
        newProducts=sessionCubit.state.database.productDatabse.filterProducts(from, to, filter);
        for(int i=0;i<newProducts.length;i++)
        {
          products[i+from]=newProducts[i];
        }
        break;
      }
      newProducts.add(products[i]!); 
    }
    emit(newProducts);
  }
}