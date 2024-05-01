import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:ingreedio_front/logic/filters.dart';
class SearchScreenData<T>
{
  SearchScreenData(this.from,this.to,this.data,this.filter);
  Filter<T> filter;
  SearchScreenData clone()
  {
    return SearchScreenData(from, to, data,filter.clone());
  }
  int from,to;
  List<T> data;
}
abstract class ListCubit<T> extends Cubit<SearchScreenData<T>?>
{
  Map<int,T> items={};
  Filter<T> get lastFilter;
  set lastFilter(Filter<T> value);
  ListCubit(super.initialState)
  {
    if(state!= null)
    {
      for(int i=0;i<state!.data.length;i++)
      {
       items[i]=state!.data[i];
      }
    }
  }
  ListCubit.empty():super(null);
  List<T> getItems(int from,int to,Filter<T> filter,BuildContext context);
  Future<void> loadData(int from,int to,Filter<T> filter,BuildContext context,{bool reset=false}) async
  {
    emit(null);
    if(filter!=lastFilter||reset)
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
    emit(SearchScreenData(from, to, newItems,filter));
  }
}