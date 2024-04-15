import 'package:flutter/material.dart';
import 'package:ingreedio_front/creators/common_creators.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/users.dart';

class ProducerCreator extends Creator<Producer> {
  const ProducerCreator({super.key, required super.reference,super.onChanged=doNothing});
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
        LabelWidget(label: "Company name",
          child: StringCreator(item: widget.item.companyName,
          onChanged: (value){widget.item.companyName=value;},)
        ),
        LabelWidget(label: "nip",
          child: StringCreator(item: widget.item.nip,
          onChanged: (value){widget.item.nip=value;},)
        ),
        LabelWidget(label: "telephone",
          child: StringCreator(item: widget.item.telephoneNumber,
          onChanged: (value){widget.item.telephoneNumber=value;},)
        ),
        LabelWidget(label: "Representative name",
          child: StringCreator(item: widget.item.representativeName,
          onChanged: (value){widget.item.representativeName=value;},)
        ),
        LabelWidget(label: "Representative surname",
          child: StringCreator(item: widget.item.representativeSurname,
          onChanged: (value){widget.item.representativeSurname=value;},)
        ),
      ],
    );
  }
}
