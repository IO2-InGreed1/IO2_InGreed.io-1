import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ingreedio_front/creators/creators.dart';
//unsigned int
class UnsignedIntCreator extends Creator<int> {
  UnsignedIntCreator({super.key,super.onChanged=doNothing,int item=0}):super(reference: ItemWrapper<int>(item));
  const UnsignedIntCreator.formReference({super.key,super.onChanged=doNothing,required super.reference});
  @override
  State<UnsignedIntCreator> createState() => _UnsignedIntCreatorState();
  @override
  Creator<int> getInstance({Key? key, Function(int p1) onChanged = doNothing, required ItemWrapper<int> reference}) {
    return UnsignedIntCreator.formReference(reference: reference,key: key,onChanged: onChanged);
  }
}
class _UnsignedIntCreatorState extends State<UnsignedIntCreator> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 200,
              child: TextFormField(
              controller: TextEditingController()..text=widget.item.toString(),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly],
              onChanged: (value)
              {
                try
                {
                  widget.item=int.parse(value);
                }
                catch(e)
                {
                 //
                }
              },
            ),
          );
  }
}
//string 
class StringCreator extends Creator<String> {
  StringCreator({super.key,super.onChanged=doNothing,String item="",this.allowMultiline=false}):super(reference: ItemWrapper<String>(item));
  const StringCreator.formReference({super.key,super.onChanged=doNothing,required super.reference,this.allowMultiline=false});
  final bool allowMultiline;
  @override
  State<StringCreator> createState() => _StringCreatorState();
  
  @override
  Creator<String> getInstance({Key? key, Function(String p1) onChanged = doNothing, required ItemWrapper<String> reference}) {
    return StringCreator.formReference(reference: reference,key: key,onChanged: onChanged);
  }
}
class _StringCreatorState extends State<StringCreator> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 200,
              child: TextFormField(
              controller: TextEditingController()..text=widget.item,
              onChanged: (value){
                widget.item=value;
                },
                maxLines: widget.allowMultiline?null:1,
              ),
            );
  }
}
//double
class DoubleCreator extends Creator<double> {
  DoubleCreator({super.key,super.onChanged=doNothing,double item=0}):super(reference: ItemWrapper<double>(item));
  const DoubleCreator.formReference({super.key,super.onChanged,required super.reference});
  @override
  State<DoubleCreator> createState() => _DoubleCreatorState();
  
  @override
  Creator<double> getInstance({Key? key, Function(double p1) onChanged = doNothing, required ItemWrapper<double> reference}) {
    return DoubleCreator.formReference(reference: reference,key: key,onChanged: onChanged,);
  }
}
class _DoubleCreatorState extends State<DoubleCreator> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: TextFormField(
          keyboardType:const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'(^-?\d*\.?\d*)'))
          ],
          onChanged: (value){
            try
            {
              widget.item=double.parse(value);
            }
            catch(e){
              //
            }
          },
      ),
    );
  }
}

class SwichButtonWidget extends Creator<bool> {
  const SwichButtonWidget({super.key, required super.reference,super.onChanged,this.title=""});
  final String title;
  @override
  State<SwichButtonWidget> createState() => _SwichButtonWidgetState();
  
  @override
  Creator<bool> getInstance({Key? key, Function(bool p1) onChanged = doNothing, required ItemWrapper<bool> reference}) {
    return SwichButtonWidget(reference: reference,key: key,onChanged: onChanged,);
  }
}
class _SwichButtonWidgetState extends State<SwichButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
            title: Text(widget.title),
            value: widget.item,
            onChanged: (val) {
              setState(() 
              {
                widget.item=val;
              });
            },
          );
  }
}

