import 'package:flutter/material.dart';
import 'package:ingreedio_front/creators/common_creators.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/creators/ingredient_creator.dart';
import 'package:ingreedio_front/database/databse.dart';
import 'package:ingreedio_front/products.dart';
import 'package:ingreedio_front/users.dart';

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
      mainAxisAlignment:MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
            const Text("Name: "),
            StringCreator(
              item: widget.item.name,
              onChanged: (val){widget.item.name=val;},
            ),
          ],
        ),
        const Text("Allergens: "),
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
          const Text("Prefferences: "),
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