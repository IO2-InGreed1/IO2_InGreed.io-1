import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ingreedio_front/creators.dart';
//unsigned int
class UnsignedIntCreator extends Creator<int> {
  UnsignedIntCreator({super.key,super.item=0,super.onChanged=doNothing});

  @override
  State<UnsignedIntCreator> createState() => _UnsignedIntCreatorState();
}
class _UnsignedIntCreatorState extends State<UnsignedIntCreator> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 40,
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
  StringCreator({super.key,super.item="",super.onChanged=doNothing});

  @override
  State<StringCreator> createState() => _StringCreatorState();
}

class _StringCreatorState extends State<StringCreator> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 40,
              child: TextFormField(
              controller: TextEditingController()..text=widget.item,
              onChanged: (value){
                widget.item=value;
                },
                    ),
            );
  }
}
//double
class DoubleCreator extends Creator<double> {
  DoubleCreator({super.key, super.item=0,super.onChanged=doNothing});

  @override
  State<DoubleCreator> createState() => _DoubleCreatorState();
}

class _DoubleCreatorState extends State<DoubleCreator> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
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

