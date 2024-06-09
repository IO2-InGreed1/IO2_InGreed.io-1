import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:ingreedio_front/assets.dart';
import 'package:ingreedio_front/ui/common_ui_elements.dart';
import 'package:ingreedio_front/ui/widgets/opinion_widget.dart';
import 'package:ingreedio_front/ui/widgets/product_widget.dart';
import 'package:ingreedio_front/logic/users.dart';
part 'products.mapper.dart';
@MappableEnum()
enum Category
{
  cosmetics("cosmetics",Icons.brush,1),
  food("food",Icons.fastfood,2),
  drink("drink",Icons.local_drink,3),
  other("other",Icons.question_mark,4);
  const Category(this.name,this.icon,this.backendNumber);
  static Category? fromNumber(int number)
  {
    switch (number) {
      case 0:
        return null;
      case 1:
        return Category.cosmetics;
      case 2:
        return Category.food;
      case 3:
        return Category.drink;
      case 4:
        return Category.other;
      default:
        return null;
    }
  }
  final String name;
  final int backendNumber;
  final IconData icon;
}
@MappableClass()
class Product with ProductMappable
{
  @override
  bool operator==(Object other)
  {
    if(other is! Product) return false;
    return other.id==id&&other.name==name&&other.category==category&&other.description==description&&iconURL==other.iconURL;
  }
  Product.empty():id=0,name="",description="",promotionUntil=DateTime(2000),category=Category.cosmetics,ingredients=[],iconURL="",producer=Producer.fromAllData(companyName: "CompanyName", nip: "1", representativeName: "representativeName", representativeSurname: "representativeSurname", telephoneNumber: "123123123",
      id: 0, isBlocked: false, mail: 'mail', password: '', username: 'producer');
 @MappableConstructor()
  Product.fromAllData({
    required this.category,
    required this.description,
    required this.id,
    required this.ingredients,
    required this.name,
    required this.producer,
    required this.promotionUntil,
    this.isReported=false,
    this.iconURL="",
  });
  Product.clone(Product product):this.fromAllData(category: product.category, description: product.description, id: product.id, ingredients: product.ingredients.map((e) => e).toList(), name: product.name, producer: product.producer, promotionUntil: product.promotionUntil,iconURL: product.iconURL);
  Widget get iconWidget=>ProductIconWidget(product: this);
  Widget get productWidget=>ProductWidget(product: this);
  Widget get image
  {
    return SizedBox(
      width: 200,
      child: Image.network(
        iconURL,
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return const LoadingWidget();
          }
        },
        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
          return Assets.placeholderImage;
        },
      ),
    );
  }
  Widget clickableIconWidget(BuildContext context)
  {
    return GestureDetector(onTap: (){
      Navigator.push(context, MaterialPageRoute(
        builder:(context)=>Scaffold(body: ProductAndOpinionWidget(product: this),appBar: getStandardAppBar(context),)
        ));
      },child: iconWidget);
  }
  int id;
  String name,description;
  DateTime promotionUntil;
  Producer producer;
  List<Ingredient> ingredients;
  Category category;
  String iconURL;
  bool isReported=false;
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
  Ingredient.fromAllData({this.iconURL="",required this.id,required this.name});
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