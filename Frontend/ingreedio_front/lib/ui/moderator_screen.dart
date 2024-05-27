import 'package:flutter/material.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/logic/admins.dart';
import 'package:ingreedio_front/ui/common_ui_elements.dart';
import 'package:ingreedio_front/ui/opinion_search_screen.dart';
import 'package:ingreedio_front/ui/product_search_screen.dart';

class ModeratorScreen extends StatelessWidget {
  const ModeratorScreen({super.key, required this.moderator});
  final Moderator moderator;


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
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Scaffold(appBar: AppBar(),body: SingleChildScrollView(child: moderator.moderatorProfileWidget))));
              }, child: moderator.moderatorWidget),
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
              Expanded(flex: 3,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      reportedItemsWidget(context),
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
                          moderator.moderatorProfileWidget,
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
Widget reportedItemsWidget(BuildContext context)
{
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  StandardDecorator(
                                    color: Theme.of(context).colorScheme.secondary,
                                    child: const SizedBox(width:250, height: 450, 
                                    child: LabelWidget(
                                      isHorizontal: false,
                                      label: "Reported opinions",
                                      child: Expanded(child: ReportedOpinionSearchScreen())))
                                      ,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  StandardDecorator(
                                    color: Theme.of(context).colorScheme.secondary,
                                    child: const SizedBox(height: 450, 
                                    child: LabelWidget(
                                      isHorizontal: false,
                                      label: "Reported products",
                                      child: Expanded(child: ReportedProductSearchScreen())))
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
}