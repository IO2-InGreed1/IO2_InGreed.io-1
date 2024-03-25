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
class _OneItemContainer<T>
{
  _OneItemContainer(this.item);
  T item;
}
abstract class Creator<T> extends StatefulWidget {
  Creator({super.key, required T item,this.onChanged=doNothing}):_container=_OneItemContainer(item);
  T get item=>_container.item;
  final void Function(T) onChanged;
  set item(T value){
    _container.item=value;
    onChanged(value);
  }
  final _OneItemContainer<T> _container;
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
  @override 
  List<T> get item =>creatorList.map((e) => e.item).toList();
  @override set item(List<T> value) {
    throw Exception("Don't change value of item in ListCreator");
  }
  final Creator<T> Function() getNewCreator;
  final double width,heigth;
  final List<Creator<T>> creatorList=List.empty(growable: true);
  ListCreator({super.key, required super.item,required this.getNewCreator,this.width=60,this.heigth=70});
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
          ...widget.creatorList.map((e) => Row(children: [e,IconButton(onPressed: (){
            setState(() {
              widget.creatorList.remove(e);
            });
          }, icon:const Icon(Icons.delete))],)),
          TextButton(onPressed: (){
            setState(() {
              widget.creatorList.add(widget.getNewCreator());
            });
          }, child:const Text("Add new item"))
        ],
      )
    );
  }
}