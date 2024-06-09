import 'package:flutter/material.dart';
import 'package:ingreedio_front/logic/admins.dart';

class AdminWidget extends StatelessWidget {
  const AdminWidget({super.key,required this.admin});
  final Admin admin;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 20,child: admin.image),
        Text(admin.username,selectionColor: Colors.black,style:const TextStyle(fontWeight: FontWeight.bold))
      ],
    );
  }
}