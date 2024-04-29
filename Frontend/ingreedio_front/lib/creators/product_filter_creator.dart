import 'package:flutter/material.dart';
import 'package:ingreedio_front/creators/common_creators.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/creators/ingredient_creator.dart';
import 'package:ingreedio_front/logic/filters.dart';
import 'package:ingreedio_front/logic/products.dart';
class ProductFilterCreator extends Creator<ProductFilter> {
  const ProductFilterCreator({super.key, required super.reference,super.onChanged,required this.ingredients});
  final List<Ingredient> ingredients;
  @override
  State<ProductFilterCreator> createState() => _ProductFilterCreatorState();
  
  @override
  Creator<ProductFilter> getInstance({Key? key, Function(ProductFilter p1) onChanged = doNothing, required ItemWrapper<ProductFilter> reference}) {
    return ProductFilterCreator(reference: reference,key: key,onChanged: onChanged,ingredients: ingredients,);
  }
}

class _ProductFilterCreatorState extends State<ProductFilterCreator> {
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
        
        LabelWidget(label: "order by: ", child:Selector<ProductOrderType>(reference: ItemWrapper(widget.item.orderType), items: ProductOrderType.values, onChanged: (value)=>widget.item.orderType=value)
        ),
      ],
    );
  }
}