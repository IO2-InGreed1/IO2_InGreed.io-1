import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/creators/filter_creator.dart';
import 'package:ingreedio_front/cubit_logic/products_cubit.dart';
import 'package:ingreedio_front/cubit_logic/session_cubit.dart';
import 'package:ingreedio_front/logic/filters.dart';
import 'package:ingreedio_front/logic/products.dart';
import 'package:ingreedio_front/ui/common_ui_elements.dart';
import 'package:ingreedio_front/ui/product_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ProductFilter filter=ProductFilter();
  int from=0,count=5;
  ProductCubit productCubit=ProductCubit.empty();
  @override
  Widget build(BuildContext context) {
    SessionCubit sessionCubit=SessionCubit.fromContext(context);
    List<Ingredient> ingredients=sessionCubit.state.database.getAllIngredients();
    FilterCreator filterCreator=FilterCreator(reference: ItemWrapper(filter), ingredients: ingredients,);
    productCubit.loadData(from,from+count,filter,context);
    return BlocProvider(create: (context)=>productCubit,
    child: Column(children: 
      [
        StandardDecorator(child: filterCreator),
        TextButton(onPressed: (){
          setState(() {
            filter=filterCreator.item;
          });
        }, child: const Text("reload")),
        BlocBuilder<ProductCubit,List<Product>?>(builder: (context,state){
          if(state==null)
          {
            return LoadingAnimationWidget.discreteCircle(color: Colors.green, size: 70,);
          }
          return expandableProductList(state, context);
        }),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: (){
              setState(() {
                if(from>0)
                {
                  from-=count;
                }
              });
            }, child: const Text("previous")),
            TextButton(onPressed: (){
              setState(() {
                  from+=count;
              });
            }, child: const Text("next")),
            ],
        ),
        Text(from.toString()),
      ],
    )
    );
  }
}