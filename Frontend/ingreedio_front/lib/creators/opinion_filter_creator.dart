import 'package:flutter/material.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/logic/filters.dart';

class OpinionFilterCreator extends Creator<OpinionFilter> {
  const OpinionFilterCreator({super.key, required super.reference,super.onChanged});

  @override
  State<OpinionFilterCreator> createState() => _OpinionFilterCreatorState();
  
  @override
  Creator<OpinionFilter> getInstance({Key? key, Function(OpinionFilter p1) onChanged = doNothing, required ItemWrapper<OpinionFilter> reference}) {
    return OpinionFilterCreator(key: key,onChanged: onChanged,reference: reference,);
  }
}

class _OpinionFilterCreatorState extends State<OpinionFilterCreator> {
  @override
  Widget build(BuildContext context) {
    return LabelWidget(label: "order by: ", child:Selector<OpinionOrderType>(reference: ItemWrapper(widget.item.orderType), items: OpinionOrderType.values, onChanged: (value)=>widget.item.orderType=value));
  }
}