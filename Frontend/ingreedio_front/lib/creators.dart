import 'package:flutter/material.dart';
void doNothing(dynamic){}
class BoolCreator extends Creator<bool> {
  BoolCreator({super.key, required super.item});

  @override
  State<BoolCreator> createState() => _BoolCreatorState();
}

class _BoolCreatorState extends State<BoolCreator> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Are you sure?"));
  }
}
class ItemWrapper<T>
{
  ItemWrapper(this.item);
  T item;
}
abstract class Creator<T> extends StatefulWidget {
  Creator({super.key, required T item,this.onChanged=doNothing,ItemWrapper<T>? reference}):_container=reference ?? ItemWrapper(item);
  T get item=>_container.item;
  final void Function(T) onChanged;
  set item(T value){
    _container.item=value;
    onChanged(value);
  }
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
class DialogButton<T> extends StatelessWidget {
  const DialogButton({super.key, required this.creator, required this.onFinished, required this.child});
  final Creator<T> creator;
  final void Function(T) onFinished;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: (){
      showDialog(context: context, builder: CreatorDialog<T>(creator: creator).build).then((value) {
        if(value is T) onFinished(value);
        });
    }, child: child);
  }
}

class ListCreator<T> extends Creator<List<T>> {
  final Creator<T> Function(T) getItemCreator;
  final T Function() getNewItem;
  final double width,heigth;
  ListCreator({super.key, required super.item,required this.getItemCreator,this.width=60,this.heigth=70,required this.getNewItem});
  @override
  State<ListCreator> createState() => _ListCreatorState();
}
class _ListCreatorState extends State<ListCreator> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.heigth,
      child: ListView(
        children: [
          ...widget.item.map((e) => Row(children: [widget.getItemCreator(e),IconButton(onPressed: (){
            setState(() {
              widget.item.remove(e);
              widget.onChanged(widget.item);
            });
          }, icon:const Icon(Icons.delete))],)),
          TextButton(onPressed: (){
            setState(() {
              widget.item.add(widget.getNewItem());
              widget.onChanged(widget.item);
            });
          }, child:const Text("Add new item"))
        ],
      )
    );
  }
}

class Selector<T> extends Creator<T> {
  final List<T> items;
  Selector({super.key, required super.item,required this.items,required super.onChanged});
  @override
  State<Selector> createState() => _SelectorState();
}
class _SelectorState extends State<Selector> {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu(dropdownMenuEntries: widget.items.map((e) => DropdownMenuEntry(value: e, label: e.toString())).toList(),
    initialSelection: widget.item,
    onSelected: (value)
    {
      widget.item=value;
      widget.onChanged(value);
    },
    );
  }
}