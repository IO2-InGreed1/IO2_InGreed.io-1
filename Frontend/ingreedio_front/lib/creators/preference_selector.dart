import 'package:flutter/material.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/cubit_logic/cubit_consumer.dart';
import 'package:ingreedio_front/logic/users.dart';

class PreferenceSelector extends Creator<Preference?> {
  const PreferenceSelector({super.key, required super.reference,super.onChanged});
   @override
  State<PreferenceSelector> createState() => _PreferenceSelectorState();
  
  @override
  Creator<Preference?> getInstance({Key? key, Function(Preference? p1) onChanged = doNothing, required ItemWrapper<Preference?> reference}) {
    return PreferenceSelector(reference: reference,key: key,onChanged: onChanged);
  }
}

class _PreferenceSelectorState extends State<PreferenceSelector> {
  @override
  Widget build(BuildContext context) {
    return PreferenceConsumer(showLoadingScreen: true,
      child:(context,preferences)=>
      DropdownMenu<Preference>(
        dropdownMenuEntries: preferences!.map((e) => DropdownMenuEntry(value: e, label: e.name)).toList(),
        enableFilter: true,
        onSelected: (value){
        if(value is Preference)
        {
          widget.item=value;
        }
      },
      ),
    );
  }
}

class PreferenceButton extends StatelessWidget
{
  const PreferenceButton({super.key, required this.selector, required this.onClicked, required this.child});
  final PreferenceSelector selector;
  final void Function(Preference?) onClicked;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: ()=>onClicked(selector.item), child: child);
  }
  
}