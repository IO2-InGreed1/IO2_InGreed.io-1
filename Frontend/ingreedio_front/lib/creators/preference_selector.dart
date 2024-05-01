import 'package:flutter/material.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/logic/users.dart';

class PreferenceSelector extends Creator<Preference?> {
  const PreferenceSelector({super.key, required super.reference,super.onChanged,required this.preferences});
  final List<Preference> preferences;
   @override
  State<PreferenceSelector> createState() => _PreferenceSelectorState();
  
  @override
  Creator<Preference?> getInstance({Key? key, Function(Preference? p1) onChanged = doNothing, required ItemWrapper<Preference?> reference}) {
    return PreferenceSelector(reference: reference,key: key,onChanged: onChanged,preferences: preferences,);
  }
}

class _PreferenceSelectorState extends State<PreferenceSelector> {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu<Preference>(dropdownMenuEntries: widget.preferences.map((e) => DropdownMenuEntry(value: e, label: e.name)).toList(),
    enableFilter: true,
    onSelected: (value){
      if(value is Preference)
      {
        widget.item=value;
      }
    },
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