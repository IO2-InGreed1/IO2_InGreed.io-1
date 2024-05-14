import 'package:flutter/material.dart';
import 'package:ingreedio_front/logic/users.dart';
import 'package:ingreedio_front/ui/preferances_menager.dart';
import 'package:ingreedio_front/ui/product_search_screen.dart';

class ClientScreen extends StatelessWidget {
  final Client client;
  const ClientScreen({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: 
          [
            Row(
              children: 
              [
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Scaffold(appBar: AppBar(),body: PreferenceMenager(),)));
                }, child: const Text("manage preferences")),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Scaffold(appBar: AppBar(),body:const ProductSearchScreen(),)));
                }, child: const Text("search")),
              ],
            ),
            const SizedBox(width: 500,child: FavouriteProductSearchScreen()),
          ],
        ),
        client.clientProfileWidget
      ],
    );
  }
}