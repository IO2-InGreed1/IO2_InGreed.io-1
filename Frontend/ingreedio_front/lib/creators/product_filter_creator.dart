import 'package:flutter/material.dart';
import 'package:ingreedio_front/creators/common_creators.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/creators/ingredient_creator.dart';
import 'package:ingreedio_front/cubit_logic/cubit_consumer.dart';
import 'package:ingreedio_front/logic/filters.dart';
import 'package:ingreedio_front/ui/common_ui_elements.dart';
import '../logic/products.dart' as prod; 
class ProductFilterCreator extends Creator<ProductFilter> {
  const ProductFilterCreator({super.key, required super.reference,super.onChanged});
  @override
  State<ProductFilterCreator> createState() => _ProductFilterCreatorState();
  
  @override
  Creator<ProductFilter> getInstance({Key? key, Function(ProductFilter p1) onChanged = doNothing, required ItemWrapper<ProductFilter> reference}) {
    return ProductFilterCreator(reference: reference,key: key,onChanged: onChanged);
  }
}

class _ProductFilterCreatorState extends State<ProductFilterCreator> {
  @override
  Widget build(BuildContext context) {
    return IngredientConsumer(
      child:(context,ingredients)=>Column(
        children: [
          LabelWidget(isHorizontal: false,label: "product name: ", child: StringCreator(item: widget.item.nameFilter,onChanged:(value)=> widget.item.nameFilter=value,)),
          StandardDecorator(
            child: LabelWidget(isHorizontal: false,label: "wanted ingredients: ", child: IngredientListSelector(ingredients: ingredients??[],
            reference: ItemWrapper(widget.item.preference),
            onChanged: (value)
            {
              widget.item.preference=value;
            },
            ),     
            ),
          ),
            StandardDecorator(
           child: LabelWidget(isHorizontal: false,label: "not wanted ingredients: ", child: IngredientListSelector(ingredients: ingredients??[],
            reference: ItemWrapper(widget.item.allergens),
            onChanged: (value)
            {
              widget.item.allergens=value;
            },
            ),     
                     ),
                       ),
          
          LabelWidget(isHorizontal: false,label: "order by: ", child:Selector<ProductOrderType>(reference: ItemWrapper(widget.item.orderType), items: ProductOrderType.values, onChanged: (value)=>widget.item.orderType=value)),
          LabelWidget(label: "Product categoty", child:NullableSelector<prod.Category>(enableFilter: false,reference: ItemWrapper(widget.item.category), items: prod.Category.values, onChanged: (value)=>widget.item.category=value))
        ],
      ),
    );
  }
}