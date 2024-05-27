import 'package:flutter/material.dart';
import 'package:ingreedio_front/logic/admins.dart';
import 'package:ingreedio_front/ui/common_ui_elements.dart';
import 'package:ingreedio_front/ui/moderator_screen.dart';
import 'package:ingreedio_front/ui/terminal_widget.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key, required this.admin});
  final Admin admin;

  AppBar getAppBar(BuildContext context,{bool withClientProfile=false,bool buttonSubmenu=false})
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Scaffold(appBar: AppBar(),body: SingleChildScrollView(child: admin.adminProfileWidget))));
              }, child: admin.adminWidget),
            ),
          ):const SizedBox(),
          buttonSubmenu?PopupMenuButton(itemBuilder: (context)=>buttons.map((e) => PopupMenuItem(child: e)).toList()):Row(children: buttons)
          ]
      );
  }

  Widget getBody(BuildContext context,{bool withClientProfile=true})
  {
            return Row(
                children: [
                  Expanded(flex: 2,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          reportedItemsWidget(context),
                          StandardDecorator(
                                    color: Theme.of(context).colorScheme.secondary,
                                    child:const TerminalScreen()
                                  ),
                        ],
                      ),
                    )
                  ),
                  withClientProfile?Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.yellow[100],
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              admin.adminProfileWidget,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ):const SizedBox(),
                ],
              );
  }

  @override
  Widget build(BuildContext context) {
    //return Scaffold(appBar: getAppBar(context),body: getBody(context),);
    return LayoutBuilder(
      builder: (context,constraints) {
        bool withProfile=constraints.maxWidth>825;
        return Scaffold(appBar: getAppBar(context,withClientProfile: !withProfile,buttonSubmenu: !withProfile),
        body: getBody(context,withClientProfile: withProfile),);
      }
    );
  }
}