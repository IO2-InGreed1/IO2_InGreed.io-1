import 'package:ingreedio_front/creators.dart';
import 'package:ingreedio_front/database_mockup.dart';
import 'package:ingreedio_front/products.dart';

class IngredientSelector extends Selector<Ingredient> {
  IngredientSelector({super.key, required super.onChanged,required super.reference}):super(items: DatabaseWrapper.instance.getAllIngredients());
  IngredientSelector.withItems({super.key, required super.onChanged,required super.reference,required super.items});
}