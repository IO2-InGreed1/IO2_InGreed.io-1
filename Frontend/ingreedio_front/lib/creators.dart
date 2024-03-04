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
    return const Text("Are you sure?");
  }
}
abstract class Creator<T> extends StatefulWidget {
  Creator({super.key, required T item,this.onChanged=doNothing}):_pom=[item];
  T get item=>_pom[0];
  final void Function(T) onChanged;
  set item(T value){
    _pom[0]=value;
    onChanged(value);
  }
  final List<T> _pom;
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