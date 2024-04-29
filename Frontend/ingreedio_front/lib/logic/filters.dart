import 'package:ingreedio_front/logic/products.dart';
enum OrderType
{
  normal,byScoreAscending,byScoreDescending,
}
abstract class Filter<T>
{
  Filter<T> clone();
  @override 
  bool operator==(Object other)
  {
    if(other is! Filter<T>) return false;
    throw Exception("Not implemented operation");
  }
  @override
  int get hashCode => throw Exception("Not implemented operation");
}
class ProductFilter extends Filter<Product>
{
  String nameFilter="";
  List<Ingredient> preference=List.empty(growable: true);
  List<Ingredient> allergens=List.empty(growable: true);
  OrderType orderType=OrderType.normal;
  @override
  ProductFilter clone()
  {
    ProductFilter odp=ProductFilter();
    odp.allergens.addAll(allergens);
    odp.nameFilter=nameFilter;
    odp.orderType=orderType;
    odp.preference.addAll(preference);
    return odp;
  }
  @override
  bool operator==(Object other)
  {
    if(other is! ProductFilter) return false;
    if(nameFilter==other.nameFilter&&orderType==other.orderType)
    {
      if(compareLists(allergens, other.allergens)&&compareLists(preference, other.preference)) return true;
    }
    return false;
  }
  
  @override
  int get hashCode => nameFilter.hashCode+allergens.hashCode*preference.hashCode;
  
}
bool compareLists<T>(List<T> l1,List<T> l2)
{
  if(l1.length!=l2.length) return false;
  for(int i=0;i<l1.length;i++)
  {
    if(!l2.contains(l1[i])) return false;
  }
  for(int i=0;i<l1.length;i++)
  {
    if(!l1.contains(l2[i])) return false;
  }
  return true;
}