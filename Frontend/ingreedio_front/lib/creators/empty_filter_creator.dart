import 'package:flutter/material.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/logic/filters.dart';

class EmptyFilter<T> extends Filter<T>
{
  EmptyFilter();
  @override
  Filter<T> clone() {
    return EmptyFilter();
  }
  @override 
  bool operator==(Object other)
  {
    return other is EmptyFilter<T>;
  }
  
  @override
  int get hashCode => 0;  
}
class EmptyFilterCreator<T> extends Creator<EmptyFilter<T>> {
  const EmptyFilterCreator({super.key, required super.reference,super.onChanged});

  @override
  State<EmptyFilterCreator> createState() => _EmptyFilterCreatorState();
  
  @override
  Creator<EmptyFilter<T>> getInstance({Key? key, Function(EmptyFilter<T> p1) onChanged = doNothing, required ItemWrapper<EmptyFilter<T>> reference}) {
    return EmptyFilterCreator(reference: reference,onChanged: onChanged,key: key,);
  }
}

class _EmptyFilterCreatorState extends State<EmptyFilterCreator> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}