import 'package:flutter/material.dart';
import 'package:ingreedio_front/creators/common_creators.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/creators/ingredient_creator.dart';
import 'package:ingreedio_front/cubit_logic/cubit_consumer.dart';
import 'package:ingreedio_front/logic/users.dart';

class PreferenceCreator extends Creator<Preference> {
  const PreferenceCreator({super.key, required super.reference,super.onChanged});
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
    return IngredientConsumer(
      child: (context,ingredients)=>Column(
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
          IngredientListSelector(ingredients: ingredients??[],
              reference: ItemWrapper(widget.item.prefered),
              onChanged: (value)
              {
                widget.item.prefered=value;
              },
              ),     
            const Text("Prefferences: "),
            IngredientListSelector(ingredients: ingredients??[],
              reference: ItemWrapper(widget.item.allergens),
              onChanged: (value)
              {
                widget.item.allergens=value;
              },
              ),     
        ],
      ),
    );
  }
}