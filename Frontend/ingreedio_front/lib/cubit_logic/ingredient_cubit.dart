import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:ingreedio_front/cubit_logic/session_cubit.dart';
import '../logic/products.dart';
class IngredientCubit extends Cubit<List<Ingredient>?>
{
  IngredientCubit(super.initialState);
  IngredientCubit.empty():super(null);
  void loadIngredients(BuildContext context)
  {
    var database=SessionCubit.fromContext(context).database;
    database.ingredientDatabase.getAllIngredients().then((value) => emit(value));
  }
}