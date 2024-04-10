import 'package:flutter/material.dart';
import 'package:ingreedio_front/common_creators.dart';
import 'package:ingreedio_front/creators.dart';
import 'package:ingreedio_front/users.dart';

class ProducerCreator extends Creator<Producer> {
  ProducerCreator({super.key, required super.reference,super.onChanged=doNothing});
  @override
  State<ProducerCreator> createState() => _ProducerCreatorState();
  
  @override
  Creator<Producer> getInstance({Key? key, Function(Producer p1) onChanged = doNothing, required ItemWrapper<Producer> reference}) {
    return ProducerCreator(reference: reference,onChanged: onChanged,key: key,);
  }
}
class _ProducerCreatorState extends State<ProducerCreator> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          const Text("companyName: "),
          StringCreator(onChanged: (value){
            widget.item.companyName=value;
          },)
        ],),
        Row(children: [
          const Text("nip: "),
          StringCreator(onChanged: (value){
            widget.item.nip=value;
          },)
        ],),
        Row(children: [
          const Text("telephone: "),
          StringCreator(onChanged: (value){
            widget.item.telephoneNumber=value;
          },)
        ],),
        Row(children: [
          const Text("representative name: "),
          StringCreator(onChanged: (value){
            widget.item.representativeName=value;
          },)
        ],),
        Row(children: [
          const Text("representative surname: "),
          StringCreator(onChanged: (value){
            widget.item.representativeSurname=value;
          },)
        ],),
      ],
    );
  }
}
