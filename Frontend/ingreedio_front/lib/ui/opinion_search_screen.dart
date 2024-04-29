import 'package:flutter/material.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/creators/opinion_filter_creator.dart';
import 'package:ingreedio_front/cubit_logic/list_cubit.dart';
import 'package:ingreedio_front/cubit_logic/opinion_cubit.dart';
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
    _providerCubit ??= OpinionCubit(myWidget.product, null);
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
  Widget getListWidget(List<Opinion> obj, BuildContext context) {
    return Column(children: obj.map((e) => e.widget).toList());
  }
  
  @override
  set providerCubit(ListCubit<Opinion> value) {
    _providerCubit=value as OpinionCubit;
  }
}