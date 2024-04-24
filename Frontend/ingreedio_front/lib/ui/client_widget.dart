import 'package:flutter/material.dart';
import 'package:ingreedio_front/ui/common_ui_elements.dart';
import 'package:ingreedio_front/users.dart';

class ClientProfileWidget extends StatelessWidget {
  const ClientProfileWidget({super.key,required this.client});
  final Client client;
  @override
  Widget build(BuildContext context) {
    return StandardDecorator(
      color:const Color.fromARGB(255, 163, 248, 5),
      child: Column(
        children: [
          client.image,
          Text(client.username,selectionColor: Colors.white,style:const TextStyle(fontWeight: FontWeight.bold)),
          Text(client.mail,selectionColor: Colors.white,style:const TextStyle(fontWeight: FontWeight.normal)),
        ],
      ),
    );
  }
}
class ClientWidget extends StatelessWidget {
  const ClientWidget({super.key,required this.client});
  final Client client;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 20,child: client.image),
        Text(client.username,selectionColor: Colors.black,style:const TextStyle(fontWeight: FontWeight.bold))
      ],
    );
  }
}