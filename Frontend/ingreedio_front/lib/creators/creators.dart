import 'package:flutter/material.dart';
void doNothing(dynamic){}
class ItemWrapper<T>
{
  ItemWrapper(this.item);
  T item;
}
class LabelWidget extends StatelessWidget {
  const LabelWidget({super.key, required this.label, required this.child,this.padding=7,this.isHorizontal=true});
  final Widget child;
  final String label;
  final double padding;
  final bool isHorizontal;
  @override
  Widget build(BuildContext context) {
    if(isHorizontal)
    {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(label),SizedBox(width: padding,),child],
      );
    }
    else 
    {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(label),SizedBox(height: padding,),child],
      );
    }
  }
}

abstract class Creator<T> extends StatefulWidget {
  const Creator({super.key,this.onChanged=doNothing,required ItemWrapper<T> reference}):_container=reference;
  T get item=>_container.item;
  final void Function(T) onChanged;
  set item(T value){
    _container.item=value;
    onChanged(value);
  }
  Creator<T> getInstance({Key? key,Function(T) onChanged=doNothing,required ItemWrapper<T> reference});
  final ItemWrapper<T> _container;
}
class CreatorDialog<T> extends StatelessWidget {
  const CreatorDialog({super.key, required this.creator});
  final Creator<T> creator;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: creator,
        ),
      ),
      actions: [
    ElevatedButton(
        onPressed: () => Navigator.pop(context,null),
        child: const Text('cancel')),
    ElevatedButton(
        onPressed: () => Navigator.pop(context, creator.item),
        child: const Text('confirm')),
      ],
    );
  }
}
bool alwaysAllow()=>true;
class DialogButton<T> extends StatelessWidget {
  const DialogButton({super.key, required this.creator, required this.onFinished, required this.child,this.canClick=alwaysAllow});
  final Creator<T> creator;
  final void Function(T) onFinished;
  final bool Function() canClick;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: (){
      if(canClick())
      {
      showDialog(context: context, builder: CreatorDialog<T>(creator: creator).build).then((value) {
        if(value is T) onFinished(value);
        });
      }
    }, child: child);
  }
}
class DialogEditButton<T> extends StatelessWidget {
  const DialogEditButton({super.key, required this.creator, required this.onFinished, required this.child,required this.onClicked});
  final Creator<T> creator;
  final void Function(T) onFinished;
  final T? Function() onClicked;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: (){
      T? value=onClicked();
      if(value is T)
      {
      showDialog(context: context, builder: CreatorDialog<T>(creator: creator.getInstance(reference: ItemWrapper(value),onChanged: creator.onChanged)).build).then((value) {
        if(value is T) onFinished(value);
        });
      }
    }, child: child);
  }
}

class ListCreator<T> extends Creator<List<ItemWrapper<T?>>> {
  final Creator<T?> creator;
  const ListCreator({required this.creator,super.key,required super.reference,super.onChanged,this.hidable=true});
  @override
  State<ListCreator> createState() => _ListCreatorState<T>();
  final bool hidable;
  @override
  Creator<List<ItemWrapper<T?>>> getInstance({Key? key, Function(List<ItemWrapper<T?>> p1) onChanged = doNothing,required ItemWrapper<List<ItemWrapper<T?>>> reference}) {
    return ListCreator(reference: reference,key: key,onChanged: onChanged, creator: creator,);
  }
}
class _ListCreatorState<T> extends State<ListCreator<T?>> {
  bool hidden=false;
  List<Widget> itemsToList()
  {
    List<Widget> widgets=List.empty(growable: true);
    for(int i=0;i<widget.item.length;i++)
    {
      widgets.add(
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.creator.getInstance(
              reference: widget.item[i],
              onChanged: (value)
              {
                widget.onChanged(widget.item);
              }),
              IconButton(onPressed: ()
              {
                setState(() {
                  widget.item.removeAt(i);
                  widget.onChanged(widget.item);
                });
              },
              icon:const Icon(Icons.delete))],));
    }
    return widgets;
  }
  @override
  Widget build(BuildContext context) {

  List<Widget> widgets=List.empty(growable: true);
   if(widget.hidable)
   {
    if(hidden)
    {
      widgets.add(TextButton(onPressed: 
      (){
        setState(() {
          hidden=!hidden;
        });
      }, child: const Icon(Icons.arrow_downward)));
      return Column(children: widgets,);
    }
    else 
    {
      widgets.add(TextButton(onPressed: 
      (){
        setState(() {
          hidden=!hidden;
        });
      }, child: const Icon(Icons.arrow_upward)));
    }
   }
   widgets.add(Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...itemsToList(),
        TextButton(onPressed: (){
          setState(() {
            widget.item.add(ItemWrapper<T?>(null));
            widget.onChanged(widget.item);
          });
        }, child:const Text("Add new item"))
      ],
    )
    );
  return Column(children: widgets,);
  }
}

class Selector<T extends Enum> extends Creator<T> {
  final List<T> items;
  final bool enableFilter;
  const Selector({this.enableFilter=true,super.key, required super.reference,required this.items,required super.onChanged});
  @override
  State<Selector> createState() => _SelectorState<T>();
  
  @override
  Creator<T> getInstance({Key? key, Function(T p1) onChanged = doNothing, required ItemWrapper<T> reference}) {
    return Selector(reference: reference, items: items, onChanged: onChanged);
  }
}
class _SelectorState<T extends Enum> extends State<Selector<T>> {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu(dropdownMenuEntries: widget.items.map((e) => DropdownMenuEntry(value: e, label: e.name)).toList(),
    onSelected: (value)
    {
      if(value is T)
      {
        widget.item=value;
        widget.onChanged(value);
      }
    },
    enableFilter: widget.enableFilter,
    );
  }
}
class NullableSelector<T extends Enum> extends Creator<T?> {
  final List<T> items;
  final String nullName;
  final bool enableFilter;
  const NullableSelector({this.enableFilter=true,super.key, required super.reference,required this.items,required super.onChanged,this.nullName="none"});
  @override
  State<NullableSelector> createState() => _NullableSelectorState<T>();
  
  @override
  Creator<T?> getInstance({Key? key, Function(T? p1) onChanged = doNothing, required ItemWrapper<T?> reference}) {
    return NullableSelector(reference: reference, items: items, onChanged: onChanged);
  }
}
class _NullableSelectorState<T extends Enum> extends State<NullableSelector<T>> {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu(dropdownMenuEntries: widget.items.map((e) => DropdownMenuEntry<T?>(value: e, label: e.name)).toList()..add(DropdownMenuEntry(value: null, label: widget.nullName)),
    onSelected: (value)
    {
      if(value is T)
      {
        widget.item=value;
        widget.onChanged(value);
      }
    },
    enableFilter: widget.enableFilter,
    initialSelection: widget.item,
    );
  }
}

class ConfirmCreator extends Creator<bool> {
  ConfirmCreator({super.key,}):super(reference: ItemWrapper(true));

  @override
  State<ConfirmCreator> createState() => _ConfirmCreatorState();
  
  @override
  Creator<bool> getInstance({Key? key, Function(bool p1) onChanged = doNothing, required ItemWrapper<bool> reference}) {
    return ConfirmCreator(key: key,);
  }
}

class _ConfirmCreatorState extends State<ConfirmCreator> {
  @override
  Widget build(BuildContext context) {
    return const Text("Are you sure?");
  }
}
class ConfirmDialogButton extends DialogButton<bool> {
  ConfirmDialogButton({super.key, required super.onFinished, required super.child}):super(creator: ConfirmCreator());
}