
import 'package:flutter/material.dart';
import 'package:ingreedio_front/creators/common_creators.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/logic/users.dart';
import 'package:ingreedio_front/ui/common_ui_elements.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({super.key,required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        user.image,
        Text(user.username,selectionColor: Colors.white,style:const TextStyle(fontWeight: FontWeight.bold)),
        Text(user.mail,selectionColor: Colors.white,style:const TextStyle(fontWeight: FontWeight.normal)),
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
AppBar getUserAppBar(BuildContext context,{required User user, bool withClientProfile=false,bool buttonSubmenu=false})
  {
    List<Widget> buttons=[
      IconButton(
              icon:const Row(
              children: 
              [
                Icon(Icons.info),
                Text("about us")
              ],
            ),
            onPressed: () 
            {
              // Handle About Us
            },),
            IconButton(
              icon:const Row(
              children: 
              [
                Icon(Icons.attach_money),
                Text("pricing")
              ],
            ),
            onPressed: () 
            {
              // Handle About Us
            },),
            IconButton(
              icon:const Row(
              children: 
              [
                Icon(Icons.article),
                Text("terms and conditions")
              ],
            ),
            onPressed: () 
            {
              // Handle About Us
            },),
    ];
    return AppBar(
      flexibleSpace: gradient,
        title: const Row(
          children: [
            GoToHomeButton(),
            SearchButton(),
          ],
        ),
        actions: [
          withClientProfile?SizedBox(
            width: 80,
            child: StandardDecorator(
              color: Theme.of(context).colorScheme.secondary,
              curve: 100,
              padding: 0,
              child: TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Scaffold(appBar: AppBar(),body: SingleChildScrollView(child: user.userProfileWidget))));
              }, child: Text(user.username)),
            ),
          ):const SizedBox(),
          buttonSubmenu?PopupMenuButton(itemBuilder: (context)=>buttons.map((e) => PopupMenuItem(child: e)).toList()):Row(children: buttons)
          ]
      );
  }