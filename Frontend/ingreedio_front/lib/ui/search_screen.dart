import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/cubit_logic/list_cubit.dart';
import 'package:ingreedio_front/logic/filters.dart';
import 'package:ingreedio_front/ui/common_ui_elements.dart';
abstract class SearchScreen<T> extends StatefulWidget {
  const SearchScreen({super.key,this.maxRows=10, this.maxColumns=5});
  final int maxRows,maxColumns;
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
  //int rows, columns;
  int columns=2,rows=10;
  int get count=>columns*rows;
  SearchScreenData<T>? lastData;
  //cubit
  ListCubit<T> get providerCubit;
  //list widget
  Widget getListWidget(List<T> list,BuildContext context)
  {
    return LayoutBuilder(
      builder: (context,constraints) {
        //columns=widget.maxColumns;
        //rows=widget.maxRows;
        //if(columns>widget.maxColumns) columns=widget.maxColumns;
        //if(rows>widget.maxRows) rows=widget.maxRows;
        if(list.isEmpty) return const SizedBox();
        return Grid(columns: columns, children: list.getRange(0, columns*rows>list.length?list.length:columns*rows).map((e) => getObjectWidget(e, context)).toList());
      }
    );
  }
  Widget get applyButton
  {
    return TextButton(
              onPressed: ()
              {
                setState(() {
                filter=filterCreator.item.clone();
                });
              }, 
              child: const Text("apply filter")
            );
  }
  Widget get reloadButton
  {
    return TextButton(
              onPressed: ()
              {
                refresh();
              }, 
              child: const Text("reload")
            );
  }
  Widget getFilterWidget(Widget filterWidget)
  {
    return Column(mainAxisAlignment: MainAxisAlignment.center,
    children: [
      StandardDecorator(child: filterCreator),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [applyButton,reloadButton],
        ),],
    );
  }
  set providerCubit(ListCubit<T> value);
  Widget putWidgets(Widget listWidget,Widget filterWidget)
  {
    return Column(mainAxisAlignment: MainAxisAlignment.center,children:[filterWidget,listWidget]);
  }
  @override
  Widget build(BuildContext context) {
    providerCubit.loadData(from,from+count,filter,context);
    Widget filterWidget=getFilterWidget(filterCreator);
    Widget listWidget=Column(mainAxisAlignment: MainAxisAlignment.center,
    children: [BlocBuilder<ListCubit<T>,SearchScreenData<T>?>(builder: (context,state)
        {
          if(lastData!=null&&filter!=lastData!.filter) lastData=null;
          if(lastData!=null&&lastData!.from==from&&lastData!.to==from+count)
          {
            return getListWidget(lastData!.data, context);
          }
          if(state==null||state.from!=from||state.to!=from+count||state.filter!=filter)
          {
            return const LoadingWidget();
          }
          lastData=state;
          maks=state.maxCount;
          return getListWidget(state.data, context);
        }),
        listControlWidgets,
      ]
    );
    return BlocProvider(create: (context)=>providerCubit,
    child: putWidgets(listWidget, filterWidget)
    );
  }
  Widget get listControlWidgets
  {
    return Column(
      children: [
        Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(onPressed: (){
            setState(() {
              if(from>=count) 
              {
                from-=count;
              } 
              else 
              {
                from=0;
              }
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
    );
  }
}