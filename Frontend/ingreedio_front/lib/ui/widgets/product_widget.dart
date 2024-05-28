import 'package:flutter/material.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/cubit_logic/session_cubit.dart';
import 'package:ingreedio_front/logic/products.dart';
import 'package:ingreedio_front/ui/common_ui_elements.dart';
import 'package:ingreedio_front/ui/widgets/ingredient_widget.dart';
import '../screens/opinion_search_screen.dart';
class ProductAndOpinionWidget extends StatefulWidget {
  const ProductAndOpinionWidget({super.key,required this.product});
  final Product product;
  @override
  State<ProductAndOpinionWidget> createState() => _ProductAndOpinionWidgetState();
}
class _ProductAndOpinionWidgetState extends State<ProductAndOpinionWidget> {
  @override
  Widget build(BuildContext context) {
    List<Widget> children=[ widget.product.productWidget,OpinionSearchScreen(product: widget.product),];
    return Center(
      child: SingleChildScrollView(
        child: Column
        (
          children: children
        ),
      ),
    );
  }
}
class ProductIconWidget extends StatelessWidget {
  const ProductIconWidget({super.key,required this.product,this.heigth=80,this.width=300});
  final Product product;
  final double heigth;
  final double width;
  @override
  Widget build(BuildContext context) {
    return StandardDecorator(color: Colors.green,child:
    Row(children: [
      SizedBox(height: heigth,child: product.image),
      SizedBox(height: heigth,
      width: width,
        child: Column(
          children: [
            Text(product.name,selectionColor: Colors.white,maxLines: 2,style:const TextStyle(fontWeight: FontWeight.bold)),
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
                  SessionCubit.fromContext(context).state.currentClient!=null?getFavoriteButton((p0) 
                  {
                    SessionCubit.fromContext(context).setFavouriteProduct(product, p0);
                  }, SessionCubit.fromContext(context).state.currentClient!.favoriteProducts.contains(product)
                  ):const Text(""),
                  SessionCubit.fromContext(context).state.isLoggedIn?DialogButton(creator: ConfirmCreator(),
                   onFinished: (val){ 
                    SessionCubit.fromContext(context).database.productDatabse.setProductReportState(product,state: true);
                   }, child: const Text("Report"))
                  :const Text(""),
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