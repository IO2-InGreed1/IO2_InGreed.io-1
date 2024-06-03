import 'package:flutter/material.dart';
import 'package:ingreedio_front/logic/users.dart';

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