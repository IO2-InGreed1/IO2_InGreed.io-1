import 'package:flutter/material.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/creators/opinion_creator.dart';
import 'package:ingreedio_front/cubit_logic/session_cubit.dart';
import 'package:ingreedio_front/logic/products.dart';
import 'package:ingreedio_front/ui/common_ui_elements.dart';
import 'package:ingreedio_front/ui/ingredient_widget.dart';
import 'package:ingreedio_front/logic/users.dart';
class ProductAndOpinionWidget extends StatefulWidget {
  const ProductAndOpinionWidget({super.key,required this.product,required this.user});
  final Client user;
  final Product product;
  @override
  State<ProductAndOpinionWidget> createState() => _ProductAndOpinionWidgetState();
}

class _ProductAndOpinionWidgetState extends State<ProductAndOpinionWidget> {
  @override
  Widget build(BuildContext context) {
    var list=SessionCubit.fromContext(context).state.database.opinionDatabase.getProductOpinions(widget.product);
    var creator=OpinionCreator(reference:ItemWrapper(Opinion.fromAllData(author: widget.user, id: 0, product: widget.product, score: 2.5, text: "")),);
    return LayoutBuilder(
      builder: (context,constraints) {
        double width=constraints.maxWidth;
        double height=constraints.maxHeight;
        double maxWidth=4*height/5;
        if(width>maxWidth) width=maxWidth;
        return Center(
          child: SizedBox(
            width: width,
            child: SingleChildScrollView(
              child: Column
              (
                children: 
                [
                  widget.product.productWidget,
                  ...list.map((e) => Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: e.widget,
                  )),
                  DialogButton(creator: creator, onFinished: (value)
                  {
                    SessionCubit.fromContext(context).state.database.opinionDatabase.addOpinion(value);
                    setState(() {});
                  }, 
                  child:const Text("Add opinion"))
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
Widget expandableProductList(List<Product> products,BuildContext context)
{
  return Column(
    children: 
    products.map((e){
    return GestureDetector(onTap: (){
      Navigator.push(context, MaterialPageRoute(
        builder:(context)=>Scaffold(body: ProductAndOpinionWidget(product: e,user: Client.empty(),),appBar: AppBar(),)
        ));
      },child: e.iconWidget);}
    ).toList(),
  );
}
class ProductIconWidget extends StatelessWidget {
  const ProductIconWidget({super.key,required this.product,this.heigth=70});
  final Product product;
  final double heigth;
  @override
  Widget build(BuildContext context) {
    return StandardDecorator(color: Colors.green,child:
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
                  StandardDecorator(child: Text(product.description)),
                  padding,
                  LabelWidget(label: "Brand: ", child: Text(product.producer.companyName)),
                  padding,
                  LabelWidget(label: "Ingredients: ", child: IngredientListWidget(ingredients: product.ingredients,)),
                  padding,
                  getFavoriteButton((p0) { 
                    
                  }, false),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
ToggleButton getFavoriteButton(void Function(bool) onChanged,bool initial)
{
  return ToggleButton(item: initial,
    buttonOff:const Icon(Icons.favorite_border,color: Colors.red,),
    buttonOn: const Icon(Icons.favorite,color: Colors.red,),
    onChanged: onChanged,);
}
class ToggleButton extends Creator<bool> {
  const ToggleButton.fromReference({super.key, required super.reference,super.onChanged,required this.buttonOff,required this.buttonOn});
  ToggleButton({super.key,required bool item,super.onChanged,required this.buttonOff,required this.buttonOn}):super(reference: ItemWrapper(item));
  final Widget buttonOn;
  final Widget buttonOff;
  @override
  State<ToggleButton> createState() => _ToggleButtonState();
  
  @override
  Creator<bool> getInstance({Key? key, Function(bool p1) onChanged = doNothing, required ItemWrapper<bool> reference}) {
    return ToggleButton.fromReference(reference: reference,onChanged: onChanged,key: key,buttonOff: buttonOff,buttonOn: buttonOn,);
  }
}

class _ToggleButtonState extends State<ToggleButton> {
  @override
  Widget build(BuildContext context) {
    Widget current=widget.item?widget.buttonOn:widget.buttonOff;
    return GestureDetector(
      onTap: (){
        setState(() {
        widget.item=!widget.item;
        });
      },
      child: current,
    );
  }
}