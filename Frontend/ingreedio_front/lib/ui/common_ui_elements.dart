import 'package:flutter/material.dart';
import 'package:ingreedio_front/assets.dart';
import 'package:ingreedio_front/cubit_logic/session_cubit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
AppBar getStandardAppBar(BuildContext context,{bool buttonSubmenu=true})
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
        title: SizedBox(height: 50,child: Assets.inGreedIcon),
        actions: [
            buttonSubmenu?PopupMenuButton(itemBuilder: (context)=>buttons.map((e) => PopupMenuItem(child: e)).toList()):Row(children: buttons)
          ]
      );
  }
class StandardDecorator extends StatelessWidget {
  const StandardDecorator({super.key, required this.child,this.color=const Color.fromARGB(167, 119, 243, 25),this.padding=7,this.curve=5.0});
  StandardDecorator.column({super.key,required List<Widget> children,
  this.color=const Color.fromARGB(167, 231, 250, 29),
  this.padding=7,
  MainAxisAlignment mainAxisAlignment=MainAxisAlignment.start,
  CrossAxisAlignment crossAxisAlignment=CrossAxisAlignment.center,
  TextBaseline? textBaseline,
  TextDirection? textDirection,
  this.curve=5.0
  }):child=Column(mainAxisAlignment: mainAxisAlignment,
  crossAxisAlignment: crossAxisAlignment,
  textBaseline: textBaseline,
  textDirection: textDirection,
  children: children,);
  final double curve;
  final Widget child;
  final Color color;
  final double padding;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
                  decoration: BoxDecoration(
                color: color, 
                borderRadius: BorderRadius.circular(curve), // Zaokrąglenie rogów
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(115, 182, 176, 176).withOpacity(0.5), // Kolor cienia
                    spreadRadius: 4,
                    blurRadius: 3,
                    offset: const Offset(0, 3),
                  ),
                ],
                ),
                child: Column(children: [
                  SizedBox(height: padding,),
                  Row(
                    children: [
                      SizedBox(width: padding,),
                      child,
                      SizedBox(width: padding,)
                    ],
                  ),
                  SizedBox(height: padding,),
                ],),
      ),
    );
  }
}
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: LoadingAnimationWidget.discreteCircle(color: Colors.green, size: 70));
  }
}
class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: ()
    {
      SessionCubit.fromContext(context).reset();
      while(Navigator.canPop(context)) 
      {
        Navigator.pop(context);
      }
    }, child:const Text("logout"));
  }
}