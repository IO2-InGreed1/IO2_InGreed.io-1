import 'package:flutter/material.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/database/databse.dart';
import 'package:ingreedio_front/products.dart';

class IngredientSelector extends Selector<Ingredient> {
  IngredientSelector({super.key, required super.onChanged,required super.reference}):super(items: DatabaseWrapper.instance.getAllIngredients());
  IngredientSelector.withItems({super.key, required super.onChanged,required super.reference,required super.items});
}
class IngredientListSelector extends Creator<List<Ingredient>> {
  const IngredientListSelector({super.key, required super.reference,super.onChanged,required this.ingredients});
  final List<Ingredient> ingredients;
  @override
  State<IngredientListSelector> createState() => _IngredientListCreatorState();
  
  @override
  Creator<List<Ingredient>> getInstance({Key? key, Function(List<Ingredient> p1) onChanged = doNothing, required ItemWrapper<List<Ingredient>> reference}) {
    return IngredientListSelector(reference: reference,onChanged: onChanged,key: key,ingredients: ingredients,);
  }
}

class _IngredientListCreatorState extends State<IngredientListSelector> {
  @override
  Widget build(BuildContext context) {
    return ListCreator<Ingredient>(creator: 
          IngredientSelector.withItems(onChanged: (ingredient) {  }, 
            reference: ItemWrapper<Ingredient>( widget.ingredients.first),
            items: widget.ingredients,), 
          getNewItem: (){return widget.ingredients.first;},
          reference: ItemWrapper(List<ItemWrapper<Ingredient>>.empty(growable: true)),
          onChanged: (value)
          {
            widget.item=value.map((e) => e.item).toList();
          },
          );
  }
}