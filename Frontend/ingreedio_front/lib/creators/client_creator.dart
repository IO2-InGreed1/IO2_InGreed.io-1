import 'package:flutter/material.dart';
import 'package:ingreedio_front/creators/common_creators.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/users.dart';

class ClientCreator extends Creator<Client> {
  const ClientCreator({super.key, required super.reference,super.onChanged});

  @override
  State<ClientCreator> createState() => _ClientCreatorState();
  
  @override
  Creator<Client> getInstance({Key? key, Function(Client p1) onChanged = doNothing, required ItemWrapper<Client> reference}) {
    return ClientCreator(reference: reference,key: key,onChanged: onChanged,);
  }
}

class _ClientCreatorState extends State<ClientCreator> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LabelWidget(label: "Username", child: StringCreator(
              item: widget.item.username,
              onChanged: (value){widget.item.username=value;},
            )),
            LabelWidget(label: "Password", child: StringCreator(
              item: widget.item.password,
              onChanged: (value){widget.item.password=value;},
            )),
            LabelWidget(label: "Email", child: StringCreator(
              item: widget.item.mail,
              onChanged: (value){widget.item.mail=value;},
            )),
      ],
    );
  }
}