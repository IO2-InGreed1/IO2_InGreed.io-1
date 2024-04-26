import 'package:ingreedio_front/logic/products.dart';
enum OrderType
{
  normal,byScoreAscending,byScoreDescending,
}
class ProductFilter
{
  String nameFilter="";
  List<Ingredient> preference=List.empty(growable: true);
  List<Ingredient> allergens=List.empty(growable: true);
  OrderType orderType=OrderType.normal;
}
