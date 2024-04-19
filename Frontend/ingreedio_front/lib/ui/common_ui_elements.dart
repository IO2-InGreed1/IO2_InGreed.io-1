import 'package:flutter/material.dart';

class StandardDecorator extends StatelessWidget {
  const StandardDecorator({super.key, required this.child,this.color=const Color.fromARGB(167, 231, 250, 29)});
  final Widget child;
  final Color color;
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
                child: child,
      ),
    );
  }
}