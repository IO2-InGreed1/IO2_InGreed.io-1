import 'package:flutter/material.dart';
import 'package:ingreedio_front/creators/common_creators.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/creators/ingredient_creator.dart';
import 'package:ingreedio_front/logic/filters.dart';
import 'package:ingreedio_front/logic/products.dart';
class FilterCreator extends Creator<ProductFilter> {
  const FilterCreator({super.key, required super.reference,super.onChanged,required this.ingredients});
  final List<Ingredient> ingredients;
  @override
  State<FilterCreator> createState() => _FilterWidgetState();
  
  @override
  Creator<ProductFilter> getInstance({Key? key, Function(ProductFilter p1) onChanged = doNothing, required ItemWrapper<ProductFilter> reference}) {
    return FilterCreator(reference: reference,key: key,onChanged: onChanged,ingredients: ingredients,);
  }
}

class _FilterWidgetState extends State<FilterCreator> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LabelWidget(label: "product name: ", child: StringCreator(item: widget.item.nameFilter,onChanged:(value)=> widget.item.nameFilter=value,)),
        Row( 
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LabelWidget(label: "wanted ingredients: ", child: IngredientListSelector(ingredients: widget.ingredients,
            reference: ItemWrapper(widget.item.preference),
            onChanged: (value)
            {
              widget.item.preference=value;
            },
            ),     
            ),
           LabelWidget(label: "not wanted ingredients: ", child: IngredientListSelector(ingredients: widget.ingredients,
            reference: ItemWrapper(widget.item.allergens),
            onChanged: (value)
            {
              widget.item.allergens=value;
            },
            ),     
        ),
        ]),
        
        LabelWidget(label: "order by: ", child:Selector(reference: ItemWrapper(widget.item.orderType), items: OrderType.values, onChanged: (value)=>widget.item.orderType=value)
        ),
      ],
    );
  }
}