import 'package:flutter/material.dart';
import 'package:ingreedio_front/common_creators.dart';
import 'package:ingreedio_front/creators.dart';
import 'package:ingreedio_front/products.dart';

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
    Widget catogoryInput=DropdownMenu<Category>(
      initialSelection: widget.item.category,
        dropdownMenuEntries: Category.values.map((e) => DropdownMenuEntry(value: e, label: e.name)).toList(),
        onSelected: (val)
        {
          if(val!=null) widget.item.category=val;
          widget.onChanged(widget.item);
        },
        );
    Widget idInput=UnsignedIntCreator(
            onChanged: (value){widget.item.id=value;},
            item: widget.item.id,);
    Widget nameInput=StringCreator(
          onChanged: (value)
          {
            widget.item.name=value;
          },
          item: widget.item.name,
        );

    return Column(
      children: [
        catogoryInput,idInput,nameInput
      ],
    );
  }
}