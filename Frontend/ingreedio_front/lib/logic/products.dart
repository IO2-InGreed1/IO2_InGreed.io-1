import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:ingreedio_front/assets.dart';
import 'package:ingreedio_front/ui/opinion_widget.dart';
import 'package:ingreedio_front/ui/product_widget.dart';
import 'package:ingreedio_front/logic/users.dart';
part 'products.mapper.dart';
enum Category
{
  food,cosmetics,drink
}
@MappableClass()
class Product with ProductMappable
{
  @override
  bool operator==(Object other)
  {
    if(other is! Product) return false;
    return other.id==id&&other.name==name&&other.category==category&&other.description==description;
  }
  Product.empty():id=0,name="",description="",promotionUntil=DateTime(0),category=Category.cosmetics,ingredients=[],producer=Producer.fromAllData(companyName: "CompanyName", nip: "1", representativeName: "representativeName", representativeSurname: "representativeSurname", telephoneNumber: "123123123");
  @MappableConstructor()
  Product.fromAllData({
    required this.category,
    required this.description,
    required this.id,
    required this.ingredients,
    required this.name,
    required this.producer,
    required this.promotionUntil
  });
  Product.clone(Product product):this.fromAllData(category: product.category, description: product.description, id: product.id, ingredients: product.ingredients.map((e) => e).toList(), name: product.name, producer: product.producer, promotionUntil: product.promotionUntil);
  Widget get iconWidget=>ProductIconWidget(product: this);
  Widget get productWidget=>ProductWidget(product: this);
  Widget clickableIconWidget(BuildContext context)
  {
    return GestureDetector(onTap: (){
      Navigator.push(context, MaterialPageRoute(
        builder:(context)=>Scaffold(body: ProductAndOpinionWidget(product: this),appBar: AppBar(),)
        ));
      },child: iconWidget);
  }
  Widget get image=>Assets.placeholderImage;
  int id;
  String name,description;
  DateTime promotionUntil;
  Producer producer;
  List<Ingredient> ingredients;
  Category category;
  @override
  int get hashCode => id+name.hashCode*description.hashCode;
  

}
@MappableClass()
class Ingredient with IngredientMappable
{
  @override
  bool operator==(Object other)
  {
    if(other is! Ingredient) return false;
    return other.id==id&&other.name==name;
  }
  int id;
  String name;
  String iconURL;
  @MappableConstructor()
  Ingredient.fromAllData({required this.iconURL,required this.id,required this.name});
  @override String toString() {
    return name;
  }
  
  @override
  int get hashCode => id+name.hashCode;
  
}
@MappableClass()
class Opinion with OpinionMappable
{
  @MappableConstructor()
  Opinion.fromAllData({required this.author,required this.id,required this.product,
  required this.score,required this.text});
  Opinion.empty({required this.author,required this.product}):id=0,text="",score=0;
  int id;
  Product product;
  Client author;
  String text;
  double score;
  bool isReported=false;
  Widget get widget=>OpinionWidget(opinion: this);
  Widget get reportableWidget=>OpinionWidget(opinion: this,showReportButton: true,);
}