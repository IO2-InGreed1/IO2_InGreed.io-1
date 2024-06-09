import 'package:flutter/material.dart';
import 'package:ingreedio_front/logic/products.dart';

class IngredientListWidget extends StatelessWidget {
  const IngredientListWidget({super.key,required this.ingredients});
  final List<Ingredient> ingredients;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: ingredients.map((e) => Text(e.name)).toList(),
    );
  }
}