import 'package:flutter/material.dart';
import 'package:ingreedio_front/common_creators.dart';
import 'package:ingreedio_front/creators.dart';
import 'package:ingreedio_front/database_mockup.dart';
import 'package:ingreedio_front/ingredient_selector.dart';
import 'package:ingreedio_front/products.dart';

class PreferenceCreator extends Creator<Preference> {
  PreferenceCreator({super.key, required super.reference,super.onChanged}):ingredients=DatabaseWrapper.instance.getAllIngredients();
  final List<Ingredient> ingredients;
  @override
  State<PreferenceCreator> createState() => _PreferenceCreatorState();
  
  @override
  Creator<Preference> getInstance({Key? key, Function(Preference p1) onChanged = doNothing, required ItemWrapper<Preference> reference}) {
    return PreferenceCreator(reference: reference,onChanged: onChanged,key: key);
  }
}

class _PreferenceCreatorState extends State<PreferenceCreator> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StringCreator(
          item: widget.item.name,
          onChanged: (val){widget.item.name=val;},
        ),
        ListCreator<Ingredient>(creator: 
          IngredientSelector.withItems(onChanged: (ingredient) {  }, 
          reference: ItemWrapper<Ingredient>( widget.ingredients.first), items: widget.ingredients,), 
          getNewItem: (){return widget.ingredients.first;},
          reference: ItemWrapper(List<ItemWrapper<Ingredient>>.empty(growable: true)),
          onChanged: (value)
          {
            widget.item.allergens=value.map((e) => e.item).toList();
          },
          ),
          ListCreator<Ingredient>(creator: 
          IngredientSelector.withItems(onChanged: (ingredient) {  }, 
          reference: ItemWrapper<Ingredient>( widget.ingredients.first), items: widget.ingredients,), 
          getNewItem: (){return widget.ingredients.first;},
          reference: ItemWrapper(List<ItemWrapper<Ingredient>>.empty(growable: true)),
          onChanged: (value)
          {
            widget.item.prefered=value.map((e) => e.item).toList();
          },
          ),
      ],
    );
  }
}