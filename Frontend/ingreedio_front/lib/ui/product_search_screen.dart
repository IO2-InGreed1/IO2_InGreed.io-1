import 'package:flutter/material.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/creators/filter_creator.dart';
import 'package:ingreedio_front/cubit_logic/list_cubit.dart';
import 'package:ingreedio_front/cubit_logic/products_cubit.dart';
import 'package:ingreedio_front/cubit_logic/session_cubit.dart';
import 'package:ingreedio_front/logic/filters.dart';
import 'package:ingreedio_front/logic/products.dart';
import 'package:ingreedio_front/ui/product_widget.dart';
import 'package:ingreedio_front/ui/search_screen.dart';
class ProductSearchScreen extends SearchScreen<Product> {
  const ProductSearchScreen({super.key});

  @override
  SearchScreenState<Product> createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends SearchScreenState<Product> {
  @override
  Filter<Product> filter=ProductFilter();
  ProductFilterCreator? _filterCreator;
  @override
  Creator<Filter<Product>> get filterCreator
  {
    if(_filterCreator==null) throw Exception("filter creator not set!!!");
    return _filterCreator!;
  }
  @override 
  set filterCreator(Creator<Filter<Product>> value)
  {
    _filterCreator=value as ProductFilterCreator;
  }
  @override
  Widget build(BuildContext context)
  {
    List<Ingredient> ingredients=SessionCubit.fromContext(context).state.database.ingredientDatabase.getAllIngredients();
    filterCreator=ProductFilterCreator(reference: ItemWrapper(filter as ProductFilter), ingredients: ingredients);
    return super.build(context);
  }

  @override
  ListCubit<Product> providerCubit=ProductCubit.empty();

  @override
  Widget getListWidget(List<Product> obj, BuildContext context) {
    return expandableProductList(obj, context);
  }
}