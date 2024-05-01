import 'package:ingreedio_front/logic/products.dart';
import 'package:ingreedio_front/logic/users.dart';
enum ProductOrderType
{
  normal,byScoreAscending,byScoreDescending,
}

enum OpinionOrderType
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
    throw Exception("not implemented ==");
  }
  @override
  int get hashCode;
}
class ProductFilter extends Filter<Product>
{
  String nameFilter="";
  Producer? producer;
  List<Ingredient> preference=List.empty(growable: true);
  List<Ingredient> allergens=List.empty(growable: true);
  ProductOrderType orderType=ProductOrderType.normal;
  @override
  ProductFilter clone()
  {
    ProductFilter odp=ProductFilter();
    odp.allergens.addAll(allergens);
    odp.nameFilter=nameFilter;
    odp.orderType=orderType;
    odp.preference.addAll(preference);
    odp.producer=producer;
    return odp;
  }
  ProductFilter();
  ProductFilter.formPreference(Preference pref)
  {
    allergens=pref.allergens;
    preference=pref.prefered;
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
class OpinionFilter extends Filter<Opinion>
{
  OpinionOrderType orderType=OpinionOrderType.normal;
  @override
  Filter<Opinion> clone() {
    var odp=OpinionFilter();
    odp.orderType=orderType;
    return odp;
  }
  @override int get hashCode=>orderType.toString().hashCode;
  
  @override
  bool operator ==(Object other) {
    if(other is! OpinionFilter) return false;
    return other.orderType==orderType;
  }
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
