import 'package:flutter/material.dart';
import 'package:ingreedio_front/creators/common_creators.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/logic/admins.dart';
import 'package:ingreedio_front/ui/common_ui_elements.dart';

class ModeratorProfileWidget extends StatelessWidget {
  const ModeratorProfileWidget({super.key,required this.moderator});
  final Moderator moderator;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        moderator.image,
        Text(moderator.username,selectionColor: Colors.white,style:const TextStyle(fontWeight: FontWeight.bold)),
        Text(moderator.mail,selectionColor: Colors.white,style:const TextStyle(fontWeight: FontWeight.normal)),
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
class ModeratorWidget extends StatelessWidget {
  const ModeratorWidget({super.key,required this.moderator});
  final Moderator moderator;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 20,child: moderator.image),
        Text(moderator.username,selectionColor: Colors.black,style:const TextStyle(fontWeight: FontWeight.bold))
      ],
    );
  }
}