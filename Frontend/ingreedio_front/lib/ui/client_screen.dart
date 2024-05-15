import 'package:flutter/material.dart';
import 'package:ingreedio_front/assets.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/cubit_logic/preference_cubit.dart';
import 'package:ingreedio_front/logic/users.dart';
import 'package:ingreedio_front/ui/common_ui_elements.dart';
import 'package:ingreedio_front/ui/preferances_menager.dart';
import 'package:ingreedio_front/ui/product_search_screen.dart';

class ClientScreen extends StatelessWidget {
  final Client client;
  const ClientScreen({super.key, required this.client});
  Widget managePreferencesButton(BuildContext context)
  {
    return TextButton(
      onPressed: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Scaffold(appBar: AppBar(),body: PreferenceMenager(),)));
      }, child: const Text("manage preferences"));
  }
  Widget searchButton(BuildContext context)
  {
    return TextButton(onPressed: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Scaffold(appBar: AppBar(),body:const ProductSearchScreen(),)));
            }, child: 
              const Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search),
                Text("search")
              ],
              )
            );
  }
  AppBar getAppBar(BuildContext context,{bool withClientProfile=false})
  {
    return AppBar(
        title: Row(
          children: [
            SizedBox(height: 50,child: Assets.inGreedIcon),
            searchButton(context),
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Scaffold(appBar: AppBar(),body: SingleChildScrollView(child: client.clientProfileWidget))));
              }, child: client.clientWidget),
            ),
          ):const SizedBox(),
          PopupMenuButton(itemBuilder: (context)=>
          [
            PopupMenuItem(child: IconButton(
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
            },),),
            PopupMenuItem(child: IconButton(
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
            },),),
            PopupMenuItem(child: IconButton(
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
            },),),
          ]
          ),
        ],
      );
  }
  Widget getBody(BuildContext context,{bool withClientProfile=true})
  {
        return Row(
            children: [
              Expanded(flex: 2,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: managePreferencesButton(context)
                    ),
                    const SizedBox(width:800,child: LabelWidget(
                      isHorizontal: false,
                      label: "Favourite Products:",
                      child: FavouriteProductSearchScreen())),
                  ],
                ),
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
                          client.clientProfileWidget,
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
    PreferenceCubit.fromContext(context).loadPreferences(context,client);
    //return Scaffold(appBar: getAppBar(context),body: getBody(context),);
    return LayoutBuilder(
      builder: (context,constraints) {
        bool withProfile=constraints.maxWidth>650;
        return Scaffold(appBar: getAppBar(context,withClientProfile: !withProfile),
        body: getBody(context,withClientProfile: withProfile),);
      }
    );
  }
}