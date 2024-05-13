import 'package:flutter/material.dart';
import 'package:ingreedio_front/creators/empty_filter_creator.dart';
import 'package:ingreedio_front/cubit_logic/list_cubit.dart';
import 'package:ingreedio_front/cubit_logic/session_cubit.dart';
import 'package:ingreedio_front/database/databse.dart';
import 'package:ingreedio_front/logic/filters.dart';
import '../logic/products.dart';
class OpinionCubit extends ListCubit<Opinion>
{
  final Product product;
  OpinionCubit(this.product):super.empty();
  
  @override
  Filter<Opinion> lastFilter=OpinionFilter();
  
  @override
  Future<ListData<Opinion>> getItems(int from, int to, Filter<Opinion> filter, BuildContext context) async {
    SessionCubit sessionCubit=SessionCubit.fromContext(context);
    return await sessionCubit.database.opinionDatabase.getOpinionsFiltered(from, to,product, filter as OpinionFilter);
  }
}
class ReportedOpinionCubit extends ListCubit<Opinion>
{
  ReportedOpinionCubit():super.empty();
  
  @override
  Filter<Opinion> lastFilter=EmptyFilter();
  
  @override
  Future<ListData<Opinion>> getItems(int from, int to, Filter<Opinion> filter, BuildContext context) async {
    SessionCubit sessionCubit=SessionCubit.fromContext(context);
    return await sessionCubit.database.opinionDatabase.getReportedFilteredOpinions(from, to, filter);
  }
}