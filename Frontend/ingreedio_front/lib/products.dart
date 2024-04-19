import 'package:ingreedio_front/users.dart';

enum Category
{
  food,cosmetics,drink
}
class Product
{
  Product.empty():id=0,name="",promotionUntil=DateTime(0),category=Category.cosmetics,ingredients=[],producer=Producer.fromAllData(companyName: "", nip: "", representativeName: "", representativeSurname: "", telephoneNumber: "");
  Product.fromAllData({
    required this.category,
    required this.id,
    required this.ingredients,
    required this.name,
    required this.producer,
    required this.promotionUntil
  });
  int id;
  String name;
  DateTime promotionUntil;
  Producer producer;
  List<Ingredient> ingredients;
  Category category;
  void addOpinion(String test,User user)
  {
    //TODO: this 
    throw Exception("not implemented");
  }
  void addIngredient(Ingredient ingredient)
  {
    //TODO: this 
    throw Exception("not implemented");
  }
  void removeIngredient(Ingredient ingredient)
  {
    //TODO: this 
    throw Exception("not implemented");
  }
  void promoteUntil(DateTime time)
  {
    //TODO: this 
    throw Exception("not implemented");
  }

}
class Ingredient
{
  int id;
  String name;
  String iconUrl;
  Ingredient.fromAllData({required this.iconUrl,required this.id,required this.name});
  @override String toString() {
    return name;
  }
}
class Opinion
{
  Opinion.fromAllData({required this.author,required this.id,required this.product,
  required this.score,required this.text});
  int id;
  Product product;
  User author;
  String text;
  double score;
  bool isReported=false;
  void calculateScore(double score)
  {
    //TODO: this 
    throw Exception("not implemented");
  }
  void reportOpinion()
  {
    //TODO: this 
    throw Exception("not implemented");
  }
  void rateOpinion()
  {
    //TODO: this 
    throw Exception("not implemented");
  }
}