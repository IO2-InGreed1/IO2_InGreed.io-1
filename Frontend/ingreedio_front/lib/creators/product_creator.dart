import 'package:flutter/material.dart';
import 'package:ingreedio_front/creators/common_creators.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/creators/ingredient_creator.dart';
import 'package:ingreedio_front/cubit_logic/cubit_consumer.dart';
import 'package:ingreedio_front/logic/products.dart';

class ProductCreator extends Creator<Product> {
  const ProductCreator({super.key, required super.reference,super.onChanged=doNothing});

  @override
  State<ProductCreator> createState() => _ProductCreatorState();
  
  @override
  Creator<Product> getInstance({Key? key, Function(Product p1) onChanged = doNothing, required ItemWrapper<Product> reference}) {
    return ProductCreator(reference: reference,key: key,onChanged: onChanged,);
  }
}
class _ProductCreatorState extends State<ProductCreator> {
  @override
  Widget build(BuildContext context) {
    return IngredientConsumer(child: (context,ingredients){
    Widget catogoryInput=DropdownMenu<Category>(
      initialSelection: widget.item.category,
        dropdownMenuEntries: Category.values.map((e) => DropdownMenuEntry(value: e, label: e.name)).toList(),
        onSelected: (val)
        {
          if(val!=null) widget.item.category=val;
          widget.onChanged(widget.item);
        },
        );
    Widget nameInput=StringCreator(
          onChanged: (value)
          {
            widget.item.name=value;
          },
          item: widget.item.name,
        );
        Widget descriptionInput=StringCreator(
          onChanged: (value)
          {
            widget.item.description=value;
          },
          item: widget.item.name,
          allowMultiline: true,
        );
    Widget ingredientsInput=IngredientListSelector(reference:ItemWrapper(widget.item.ingredients),
     ingredients: ingredients ?? [],
     onChanged: (value){widget.item.ingredients=value;},);
    Widget padding=const SizedBox(height: 7,width: 7,);
    return Column(
      children: [
        LabelWidget(label: "name: ",child: nameInput),
        padding,
        LabelWidget(label: "description: ",child: descriptionInput),
        padding,
        LabelWidget(label: "category: ",child: catogoryInput),
        padding,
        LabelWidget(label: "ingredients: ",child: ingredientsInput),
      ],
    );
    });
  }
}