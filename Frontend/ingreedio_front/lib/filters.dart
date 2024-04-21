import 'package:ingreedio_front/products.dart';

abstract class Filter<T>
{
  bool filterItem(T item);
  List<T> filterList(Iterable<T> items)
  {
    List<T> odp=List.empty(growable: true);
    for (var element in items) {if(filterItem(element)) odp.add(element);}
    return odp;
  }
}
enum FilterType
{
  inclusive,exclusive
}
class IngredientProductFilter extends Filter<Product>
{
  IngredientProductFilter(this.ingredient,{this.filterType=FilterType.inclusive});
  Ingredient ingredient;
  FilterType filterType;
  @override
  bool filterItem(Product item) {
    switch(filterType)
    {
      case FilterType.inclusive:
        return item.ingredients.contains(item);
      case FilterType.exclusive:
        return !item.ingredients.contains(item);
    }
  }
  
}