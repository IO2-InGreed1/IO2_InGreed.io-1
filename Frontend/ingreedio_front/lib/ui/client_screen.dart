import 'package:flutter/material.dart';
import 'package:ingreedio_front/assets.dart';
import 'package:ingreedio_front/creators/common_creators.dart';
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
  AppBar getAppBar(BuildContext context)
  {
    return AppBar(
        title: Row(
          children: [
            SizedBox(height: 60,child: Assets.inGreedIcon),
            searchButton(context),
          ],
        ),
        actions: [
          IconButton(
            icon:const Icon(Icons.info),
            onPressed: () {
              // Handle About Us
            },
          ),
          IconButton(
            icon:const Icon(Icons.attach_money),
            onPressed: () {
              // Handle Pricing
            },
          ),
          IconButton(
            icon:const Icon(Icons.article),
            onPressed: () {
              // Handle Terms and Conditions
            },
          ),
        ],
      );
  }
  Widget getBody(BuildContext context)
  {
    return Row(
        children: [
          Expanded(flex: 2,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: managePreferencesButton(context)
                ),
                const SizedBox(width:800,child: FavouriteProductSearchScreen()),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.yellow[100],
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  client.clientProfileWidget,
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
              ),
            ),
          ),
        ],
      );
  }
  @override
  Widget build(BuildContext context) {
    PreferenceCubit.fromContext(context).loadPreferences(context,client);
    return Scaffold(appBar: getAppBar(context),
    body: getBody(context),);
  }
}