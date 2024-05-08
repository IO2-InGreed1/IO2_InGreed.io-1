import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ingreedio_front/assets.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/cubit_logic/list_cubit.dart';
import 'package:ingreedio_front/logic/filters.dart';
import 'package:ingreedio_front/ui/common_ui_elements.dart';
abstract class SearchScreen<T> extends StatefulWidget {
  const SearchScreen({super.key,this.rows=6, this.columns=2});
  final int rows,columns;
}
class Grid extends StatelessWidget {
  const Grid({super.key, required this.columns, required this.children});
  final int columns;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    List<Row> widgets=List.empty(growable: true);
    List<Widget> currentRow=List.empty(growable: true);
    for(Widget widget in children)
    {
      currentRow.add(Padding(
        padding: const EdgeInsets.all(3.0),
        child: widget,
      ));
      if(currentRow.length>=columns) 
      {
        widgets.add(
          Row
          (
            mainAxisAlignment: MainAxisAlignment.center,
            children: currentRow,
          )
        );
        currentRow=List.empty(growable: true);
      }
    }
    if(currentRow.isNotEmpty)
    {
      widgets.add(
          Row
          (
            mainAxisAlignment: MainAxisAlignment.center,
            children: currentRow,
          )
        );
        currentRow=List.empty(growable: true);
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widgets,
    );
  }
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
  Widget getObjectWidget(T obj,BuildContext context);
  //filters
  Filter<T> get filter;
  set filter(Filter<T> value);
  //filter creators
  Creator<Filter<T>> get filterCreator;
  set filterCreator(Creator<Filter<T>> value);
  //search screen data
  int from=0,maks=1000*1000*1000;
  int get count=>widget.columns*widget.rows;
  SearchScreenData<T>? lastData;
  //cubit
  ListCubit<T> get providerCubit;
  //list widget
  Widget getListWidget(List<T> list,BuildContext context)
  {
    return Grid(columns: widget.columns, children: list.map((e) => getObjectWidget(e, context)).toList());
  }
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