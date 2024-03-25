import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ingreedio_front/creators.dart';
import 'package:ingreedio_front/products.dart';

class ProductCreator extends Creator<Product> {
  ProductCreator({super.key, required super.item,super.onChanged=doNothing});

  @override
  State<ProductCreator> createState() => _ProductCreatorState();
}
class _ProductCreatorState extends State<ProductCreator> {
  @override
  Widget build(BuildContext context) {
    Widget w1=DropdownMenu<Category>(
      initialSelection: widget.item.category,
        dropdownMenuEntries: Category.values.map((e) => DropdownMenuEntry(value: e, label: e.name)).toList(),
        onSelected: (val)
        {
          if(val!=null) widget.item.category=val;
          widget.onChanged(widget.item);
        },
        );
        Widget idInput=SizedBox(width: 40,
              child: TextFormField(
              controller: TextEditingController()..text=widget.item.id.toString(),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly],
              onChanged: (value){
              try{
                  widget.item.id=int.parse(value);
                  widget.onChanged(widget.item);
                }
              catch(e){}
                    },
                    ),
            );
            Widget nameInput=SizedBox(width: 40,
              child: TextFormField(
              controller: TextEditingController()..text=widget.item.name,
              onChanged: (value){
                widget.item.name=value;
                widget.onChanged(widget.item);
                },
                    ),
            );
    
    return Column(
      children: [
        w1,idInput,nameInput
      ],
    );
  }
}