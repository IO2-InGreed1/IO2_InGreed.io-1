import 'package:flutter/material.dart';
import 'package:ingreedio_front/creators/common_creators.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/products.dart';

class OpinionCreator extends Creator<Opinion> {
  const OpinionCreator({super.key, required super.reference,super.onChanged});

  @override
  State<OpinionCreator> createState() => _OpinionCreatorState();
  
  @override
  Creator<Opinion> getInstance({Key? key, Function(Opinion p1) onChanged = doNothing, required ItemWrapper<Opinion> reference}) {
    return OpinionCreator(reference: reference,key: key,onChanged: onChanged,);
  }
}

class _OpinionCreatorState extends State<OpinionCreator> {
  @override
  Widget build(BuildContext context) {
    return StringCreator(item: widget.item.text,
    onChanged: (value){widget.item.text=value;},);
  }
}