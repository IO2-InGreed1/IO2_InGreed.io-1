import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ingreedio_front/assets.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/cubit_logic/list_cubit.dart';
import 'package:ingreedio_front/logic/filters.dart';
import 'package:ingreedio_front/ui/common_ui_elements.dart';
abstract class SearchScreen<T> extends StatefulWidget {
  const SearchScreen({super.key});
}

abstract class SearchScreenState<T> extends State<SearchScreen<T>> {
  void refresh()
  {
    setState(() 
    {
      lastData=null;
      providerCubit.loadData(from,from+count,filter,context,reset: true);
    });
  }
  Widget getListWidget(List<T> obj,BuildContext context);
  //filters
  Filter<T> get filter;
  set filter(Filter<T> value);
  //filter creators
  Creator<Filter<T>> get filterCreator;
  set filterCreator(Creator<Filter<T>> value);
  //search screen data
  int from=0,count=5,maks=1000*1000*1000;
  SearchScreenData<T>? lastData;
  //cubit
  ListCubit<T> get providerCubit;
  set providerCubit(ListCubit<T> value);
  @override
  Widget build(BuildContext context) {
    providerCubit.loadData(from,from+count,filter,context);
    return BlocProvider(create: (context)=>providerCubit,
    child: Column(children: 
      [
        StandardDecorator(child: filterCreator),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: ()
              {
                setState(() {
                filter=filterCreator.item.clone();
                });
              }, 
              child: const Text("apply filter")
            ),
            
            TextButton(
              onPressed: ()
              {
                refresh();
              }, 
              child: const Text("reload")
            ),
          ],
        ),
        BlocBuilder<ListCubit<T>,SearchScreenData<T>?>(builder: (context,state)
        {
          if(lastData!=null&&filter!=lastData!.filter) lastData=null;
          if(lastData!=null&&lastData!.from==from&&lastData!.to==from+count)
          {
            return getListWidget(lastData!.data, context);
          }
          if(state==null||state.from!=from||state.to!=from+count||state.filter!=filter)
          {
            return Assets.loadingWidget;
          }
          lastData=state;
          return getListWidget(state.data, context);
        }),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: (){
              setState(() {
                if(from>0) from-=count;
              });
            }, child: const Text("previous")),
            TextButton(onPressed: (){
              setState(() {
                if(from+count<maks) from+=count;
              });
            }, child: const Text("next")),
            ],
        ),
        Text("${from+1}-${from+count}"),
      ],
    )
    );
  }
}