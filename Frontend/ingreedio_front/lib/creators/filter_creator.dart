import 'package:flutter/material.dart';
import 'package:ingreedio_front/creators/common_creators.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/creators/ingredient_creator.dart';
import 'package:ingreedio_front/database/databse.dart';
import 'package:ingreedio_front/filters.dart';
class FilterCreator extends Creator<ProductFilter> {
  const FilterCreator({super.key, required super.reference,super.onChanged});

  @override
  State<FilterCreator> createState() => _FilterWidgetState();
  
  @override
  Creator<ProductFilter> getInstance({Key? key, Function(ProductFilter p1) onChanged = doNothing, required ItemWrapper<ProductFilter> reference}) {
    return FilterCreator(reference: reference,key: key,onChanged: onChanged,);
  }
}

class _FilterWidgetState extends State<FilterCreator> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LabelWidget(label: "product name: ", child: StringCreator(item: widget.item.nameFilter,onChanged:(value)=> widget.item.nameFilter=value,)),
        LabelWidget(label: "wanted ingredients: ", child: IngredientListSelector(ingredients: DatabaseWrapper.instance.getAllIngredients(),
        reference: ItemWrapper(widget.item.preference),
        ),     
        ),
        LabelWidget(label: "not wanted ingredients: ", child: IngredientListSelector(ingredients: DatabaseWrapper.instance.getAllIngredients(),
        reference: ItemWrapper(widget.item.allergens),
        ),     
        ),
        LabelWidget(label: "order by: ", child:Selector(reference: ItemWrapper(widget.item.orderType), items: OrderType.values, onChanged: (value)=>widget.item.orderType=value)
        ),
      ],
    );
  }
}