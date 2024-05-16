import 'package:flutter/material.dart';
import 'package:ingreedio_front/assets.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/cubit_logic/preference_cubit.dart';
import 'package:ingreedio_front/logic/users.dart';
import 'package:ingreedio_front/ui/common_ui_elements.dart';
import 'package:ingreedio_front/ui/preferances_menager.dart';
import 'package:ingreedio_front/ui/product_search_screen.dart';

class ClientScreen extends StatefulWidget {
  final Client client;
  const ClientScreen({super.key, required this.client});

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  Widget managePreferencesButton(BuildContext context)
  {
    return TextButton(
      onPressed: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Scaffold(appBar: getStandardAppBar(context),body: PreferenceMenager(),)));
      }, child: const Text("manage preferences"));
  }

  Widget searchButton(BuildContext context)
  {
    return TextButton(onPressed: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Scaffold(appBar: getStandardAppBar(context),body:const ProductSearchScreen(),))).then((_)=>setState((){}));
            }, child: 
              const Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search),
                Text("search")
              ],
              )
            );
  }

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
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Scaffold(appBar: AppBar(),body: SingleChildScrollView(child: widget.client.clientProfileWidget))));
              }, child: widget.client.clientWidget),
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
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: managePreferencesButton(context)
                    ),
                    StandardDecorator(
                      color: Theme.of(context).colorScheme.secondary,
                      child: widget.client.favoriteProducts.isNotEmpty? const SizedBox(width:450,child: LabelWidget(
                        isHorizontal: false,
                        label: "Favourite Products:",
                        child: FavouriteProductSearchScreen())):
                        Column(
                          children: [
                            const Text("Search for your favourite products"),
                            searchButton(context)
                          ],
                        )
                        ,
                    ),
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
                          widget.client.clientProfileWidget,
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
    if(PreferenceCubit.fromContext(context).state==null)
    {
      PreferenceCubit.fromContext(context).loadPreferences(context,widget.client);
    }
    //return Scaffold(appBar: getAppBar(context),body: getBody(context),);
    return LayoutBuilder(
      builder: (context,constraints) {
        bool withProfile=constraints.maxWidth>650;
        return Scaffold(appBar: getAppBar(context,withClientProfile: !withProfile,buttonSubmenu: !withProfile),
        body: getBody(context,withClientProfile: withProfile),);
      }
    );
  }
}