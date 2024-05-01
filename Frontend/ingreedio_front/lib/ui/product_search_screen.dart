import 'package:flutter/material.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/creators/product_creator.dart';
import 'package:ingreedio_front/creators/product_filter_creator.dart';
import 'package:ingreedio_front/cubit_logic/list_cubit.dart';
import 'package:ingreedio_front/cubit_logic/products_cubit.dart';
import 'package:ingreedio_front/cubit_logic/session_cubit.dart';
import 'package:ingreedio_front/logic/filters.dart';
import 'package:ingreedio_front/logic/products.dart';
import 'package:ingreedio_front/logic/users.dart';
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
    if(_filterCreator==null)
    {
      List<Ingredient> ingredients=SessionCubit.fromContext(context).state.database.ingredientDatabase.getAllIngredients();
      filterCreator=ProductFilterCreator(reference: ItemWrapper(filter.clone() as ProductFilter), ingredients: ingredients);
    }
    return super.build(context);
  }

  @override
  ListCubit<Product> providerCubit=ProductCubit.empty();

  @override
  Widget getListWidget(List<Product> obj, BuildContext context) {
    return expandableProductList(obj, context);
  }
}
//Producer screen
class ProductEditScreen extends SearchScreen<Product> {
  final Producer producer;
  const ProductEditScreen({super.key,required this.producer});

  @override
  State<SearchScreen<Product>> createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends _ProductSearchScreenState {
  ProductEditScreen get myWidget=>widget as ProductEditScreen;
  @override
  Widget build(BuildContext context) {
    (filter as ProductFilter).producer=myWidget.producer;
    return super.build(context);
  }
  @override
  Widget getListWidget(List<Product> obj, BuildContext context) {
    return Column(
      children: obj.map((e)
        {
          return Row(
            children: 
            [
              e.iconWidget,
              DialogButton<Product>
              (
                creator: 
                ProductCreator(reference: ItemWrapper(Product.clone(e)),),
                onFinished: (product) { (providerCubit as ProductCubit).editProduct(e, product, context);},
                child: const Text("edit"),
              ),
              DialogButton<Product>
              (
                creator: 
                ProductCreator(reference: ItemWrapper(Product.clone(e)),),
                onFinished: (product) { (providerCubit as ProductCubit).removeProduct(e, context);},
                child: const Text("delete"),
              )

            ],
          );
        } 
      ).toList(),
    );
  }
}