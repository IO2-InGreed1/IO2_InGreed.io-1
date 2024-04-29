import 'package:flutter/material.dart';
import 'package:ingreedio_front/cubit_logic/list_cubit.dart';
import 'package:ingreedio_front/cubit_logic/session_cubit.dart';
import 'package:ingreedio_front/logic/filters.dart';
import '../logic/products.dart';
class OpinionCubit extends ListCubit<Opinion>
{
  final Product product;
  OpinionCubit(this.product,super.initialState);
  
  @override
  Filter<Opinion> lastFilter=OpinionFilter();
  
  @override
  List<Opinion> getItems(int from, int to, Filter<Opinion> filter, BuildContext context) {
    SessionCubit sessionCubit=SessionCubit.fromContext(context);
    return sessionCubit.state.database.opinionDatabase.getOpinionsFiltered(from, to,product, filter as OpinionFilter);
  }
}