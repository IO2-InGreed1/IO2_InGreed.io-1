import 'package:flutter/material.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/creators/empty_filter_creator.dart';
import 'package:ingreedio_front/creators/opinion_filter_creator.dart';
import 'package:ingreedio_front/cubit_logic/list_cubit.dart';
import 'package:ingreedio_front/cubit_logic/opinion_cubit.dart';
import 'package:ingreedio_front/cubit_logic/session_cubit.dart';
import 'package:ingreedio_front/logic/filters.dart';
import 'package:ingreedio_front/logic/products.dart';
import 'package:ingreedio_front/ui/search_screen.dart';

class OpinionSearchScreen extends SearchScreen<Opinion> {
  const OpinionSearchScreen({super.key,required this.product});
  final Product product;
  @override
  SearchScreenState<Opinion> createState() => _OpinionSearchScreenState();
}

class _OpinionSearchScreenState extends SearchScreenState<Opinion> {

  OpinionSearchScreen get myWidget=>widget as OpinionSearchScreen;
  @override 
  Widget build(BuildContext context) 
  {
    _providerCubit ??= OpinionCubit(myWidget.product);
    return super.build(context);
  }
  @override
  Filter<Opinion> filter=OpinionFilter();

  @override
  Creator<Filter<Opinion>> filterCreator=OpinionFilterCreator(reference: ItemWrapper(OpinionFilter()));
  OpinionCubit? _providerCubit;
  @override
  ListCubit<Opinion> get providerCubit
  {
    if(_providerCubit==null) throw Exception("provider cubit not initialized");
    return _providerCubit!;
  }  
  @override
  set providerCubit(ListCubit<Opinion> value) {
    _providerCubit=value as OpinionCubit;
  }
  
  @override
  Widget getObjectWidget(Opinion obj, BuildContext context) {
    return obj.reportableWidget;
  }
}
class ReportedOpinionSearchScreen extends SearchScreen<Opinion> {
  const ReportedOpinionSearchScreen({super.key});

  @override
  SearchScreenState<Opinion> createState() => _ReportedOpinionSearchScreenState();
}

class _ReportedOpinionSearchScreenState extends SearchScreenState<Opinion> {
  
  @override 
  Widget build(BuildContext context) {
    columns=1;
    return super.build(context);
  }
  @override
  Filter<Opinion> filter=EmptyFilter();
  
  @override
  Creator<Filter<Opinion>> filterCreator=EmptyFilterCreator(reference: ItemWrapper(EmptyFilter<Opinion>()));
  
  @override
  ListCubit<Opinion> providerCubit=ReportedOpinionCubit();
  @override
  Widget putWidgets(Widget listWidget,Widget filterWidget)
  {
    return Column(mainAxisAlignment: MainAxisAlignment.center,children: [reloadButton,listWidget]);
  }
  @override
  Widget getObjectWidget(Opinion obj, BuildContext context) {
    return  Row(children: [
      obj.widget,
      ConfirmDialogButton(onFinished: (value) 
      {
        SessionCubit.fromContext(context).database.opinionDatabase.removeOpinion(obj);
      },
      child: const Text("delete opinion"),),
      ConfirmDialogButton(onFinished: (value) 
      {
        SessionCubit.fromContext(context).database.opinionDatabase.setOpinionReport(obj,reportState: false);
      },
      child: const Text("un-report opinion"),),
    ]);
  }
}