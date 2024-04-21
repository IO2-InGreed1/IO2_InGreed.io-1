import 'package:flutter/material.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/products.dart';
import 'package:ingreedio_front/ui/common_ui_elements.dart';
import 'package:ingreedio_front/ui/ingredient_widget.dart';

class ProductIconWidget extends StatelessWidget {
  const ProductIconWidget({super.key,required this.product,this.heigth=70});
  final Product product;
  final double heigth;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){Navigator.push(context, MaterialPageRoute(builder:(context)=>Scaffold(body: product.productWidget,appBar: AppBar(),)));},
      child: StandardDecorator(color: Colors.green,child:
      Row(children: [
        SizedBox(height: heigth,child: product.image),
        SizedBox(height: heigth,
          child: Column(
            children: [
              Text(product.name,selectionColor: Colors.white,style:const TextStyle(fontWeight: FontWeight.bold)),
              Text(product.description,selectionColor: Colors.white,maxLines: 2)
            ],
          ),
        ),
      ],)
      ),
    );
  }
}
class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key,required this.product});
  final Product product;
  static Widget padding=const SizedBox(height: 7,width: 7);
  @override
  Widget build(BuildContext context) {
    return StandardDecorator(
      child: Column(
        children: [
          Text(product.name,style:const TextStyle(fontWeight: FontWeight.bold),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              product.image,
              padding,
              Column(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(product.description),
                  padding,
                  LabelWidget(label: "Brand: ", child: Text(product.producer.companyName)),
                  padding,
                  LabelWidget(label: "Ingredients: ", child: IngredientListWidget(ingredients: product.ingredients,)),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}