import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
class StandardDecorator extends StatelessWidget {
  const StandardDecorator({super.key, required this.child,this.color=const Color.fromARGB(167, 119, 243, 25),this.padding=7});

  StandardDecorator.column({super.key,required List<Widget> children,
  this.color=const Color.fromARGB(167, 231, 250, 29),
  this.padding=7,
  MainAxisAlignment mainAxisAlignment=MainAxisAlignment.start,
  CrossAxisAlignment crossAxisAlignment=CrossAxisAlignment.center,
  TextBaseline? textBaseline,
  TextDirection? textDirection,
  }):child=Column(mainAxisAlignment: mainAxisAlignment,
  crossAxisAlignment: crossAxisAlignment,
  textBaseline: textBaseline,
  textDirection: textDirection,
  children: children,);

  final Widget child;
  final Color color;
  final double padding;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
                  decoration: BoxDecoration(
                color: color, 
                borderRadius: BorderRadius.circular(5.0), // Zaokrąglenie rogów
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