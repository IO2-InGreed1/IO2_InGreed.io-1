import 'package:flutter/material.dart';
import 'package:ingreedio_front/creators/common_creators.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/logic/admins.dart';
import 'package:ingreedio_front/ui/common_ui_elements.dart';

class AdminProfileWidget extends StatelessWidget {
  const AdminProfileWidget({super.key,required this.admin});
  final Admin admin;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        admin.image,
        Text(admin.username,selectionColor: Colors.white,style:const TextStyle(fontWeight: FontWeight.bold)),
        Text(admin.mail,selectionColor: Colors.white,style:const TextStyle(fontWeight: FontWeight.normal)),
        const SizedBox(height: 20),
                 const Text('Settings', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SwichButtonWidget(
                  title: 'Email notifications',
                  reference: ItemWrapper(false),
                ),
                SwichButtonWidget(
                  title: 'Push up notifications',
                  reference: ItemWrapper(false),
                ),
                ListTile(
                  title: const Text('Change Email'),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('Change Password'),
                  onTap: () {},
                ),
                 const LogoutButton(),
      ],
    );
  }
}
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