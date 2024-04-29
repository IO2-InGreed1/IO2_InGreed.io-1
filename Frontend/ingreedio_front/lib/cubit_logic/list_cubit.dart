import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:ingreedio_front/logic/filters.dart';

abstract class ListCubit<T> extends Cubit<List<T>?>
{
  Map<int,T> items={};
  Filter<T> get lastFilter;
  set lastFilter(Filter<T> value);
  ListCubit(super.initialState)
  {
    if(state!= null)
    {
      for(int i=0;i<state!.length;i++)
      {
       items[i]=state![i];
      }
    }
  }
  ListCubit.empty():super(null);
  List<T> getItems(int from,int to,Filter<T> filter,BuildContext context);
  Future<void> loadData(int from,int to,Filter<T> filter,BuildContext context) async
  {
    emit(null);
    if(!(filter==lastFilter))
    {
      items={};
      lastFilter=filter.clone();
    }
    List<T> newItems=List.empty(growable: true);
    for(int i=from;i<to;i++)
    {
      if(!items.containsKey(i))
      {
        newItems=getItems(from, to, filter,context);
        for(int i=0;i<newItems.length;i++)
        {
          items[i+from]=newItems[i];
        }
        break;
      }
      newItems.add(items[i] as T); 
    }
    emit(newItems);
  }
}