import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:ingreedio_front/database/databse.dart';
import 'package:ingreedio_front/logic/filters.dart';
class SearchScreenData<T>
{
  SearchScreenData(this.from,this.to,this.data,this.filter,this.maxCount);
  Filter<T> filter;
  SearchScreenData clone()
  {
    return SearchScreenData(from, to, data,filter.clone(),maxCount);
  }
  int from,to,maxCount;
  List<T> data;
}
abstract class ListCubit<T> extends Cubit<SearchScreenData<T>?>
{
  Map<int,T> items={};
  Filter<T> get lastFilter;
  int lastMaxCount=0;
  set lastFilter(Filter<T> value);
  ListCubit.empty():super(null);
  Future<ListData<T>> getItems(int from,int to,Filter<T> filter,BuildContext context);
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
        var newData=await getItems(i, to, filter,context);
        lastMaxCount=newData.maxCount;
        newItems.addAll(newData.list);
        for(int j=0;j+i<newItems.length;j++)
        {
          items[j+i]=newItems[i+j];
        }
        emit(SearchScreenData(from, to, newItems,filter.clone(),newData.maxCount));
        return;
      }
      newItems.add(items[i] as T); 
    }
    emit(SearchScreenData(from, to, newItems,filter.clone(),lastMaxCount));
  }
}