import 'package:flutter/material.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/logic/products.dart';

class IngredientSelector extends Creator<Ingredient?> {
  final List<Ingredient> items;
  const IngredientSelector.withItems({super.key, required super.onChanged,required super.reference,required this.items,this.showFitstValue=false});
  final bool showFitstValue;
  @override
  State<IngredientSelector> createState() {
    return _IngredientSelectorState();
  }
  
  @override
  Creator<Ingredient?> getInstance({Key? key, Function(Ingredient? p1) onChanged = doNothing, required ItemWrapper<Ingredient?> reference}) {
    return IngredientSelector.withItems(onChanged: onChanged, reference: reference, items: items);
  }
}
class _IngredientSelectorState extends State<IngredientSelector>
{
  @override
  Widget build(BuildContext context) {
    return DropdownMenu<Ingredient>(dropdownMenuEntries: widget.items.map((e) => DropdownMenuEntry(value: e, label: e.name)).toList(),
    onSelected: (value)
    {
      if(value is Ingredient)
      {
        widget.item=value;
        widget.onChanged(value);
      }
    },
    enableFilter: true,
    initialSelection: widget.item,
    );
  }
  
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
            reference: ItemWrapper<Ingredient?>(null),
            items: widget.ingredients,), 
          reference: ItemWrapper(widget.item.map((e) => ItemWrapper<Ingredient?>(e)).toList(growable: true)),
          onChanged: (value)
          {
            List<Ingredient> odp=List.empty(growable: true);
            for(int i=0;i<value.length;i++) 
            {
              if(value[i].item!=null) odp.add(value[i].item!);
            }
            widget.item=odp;
          },
          );
  }
}