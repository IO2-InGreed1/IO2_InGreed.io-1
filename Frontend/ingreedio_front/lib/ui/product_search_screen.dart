import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ingreedio_front/cubit_logic/cubit_consumer.dart';
import 'package:ingreedio_front/cubit_logic/preference_cubit.dart';
import 'package:ingreedio_front/ui/common_ui_elements.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/creators/preference_selector.dart';
import 'package:ingreedio_front/creators/product_creator.dart';
import 'package:ingreedio_front/creators/product_filter_creator.dart';
import 'package:ingreedio_front/cubit_logic/list_cubit.dart';
import 'package:ingreedio_front/cubit_logic/products_cubit.dart';
import 'package:ingreedio_front/cubit_logic/session_cubit.dart';
import 'package:ingreedio_front/logic/filters.dart';
import 'package:ingreedio_front/logic/products.dart';
import 'package:ingreedio_front/logic/users.dart';
import 'package:ingreedio_front/main.dart';
import 'package:ingreedio_front/ui/datetime_widget.dart';
import 'package:ingreedio_front/ui/product_widget.dart';
import 'package:ingreedio_front/ui/search_screen.dart';
class ProductSearchScreen extends SearchScreen<Product> {
  const ProductSearchScreen({super.key});
  @override
  SearchScreenState<Product> createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends SearchScreenState<Product> {
  @override
  Filter<Product> filter=ProductFilter();
  ProductFilterCreator? _filterCreator;
  @override
  Creator<Filter<Product>> get filterCreator
  {
    if(_filterCreator==null) throw Exception("filter creator not set!!!");
    return _filterCreator!;
  }
  @override 
  set filterCreator(Creator<Filter<Product>> value)
  {
    _filterCreator=value as ProductFilterCreator;
  }
  @override
  Widget build(BuildContext context)
  {
    return IngredientConsumer(child: (context,ingredients)
    {
    if(_filterCreator==null)
    {
      filterCreator=ProductFilterCreator(reference: ItemWrapper(filter.clone() as ProductFilter));
    }
    Client? currentClient=SessionCubit.fromContext(context).state.currentClient;
    List<Widget> widgets=List.empty(growable: true);
    if(currentClient!=null)
    {
      var pref=PreferenceSelector(reference: ItemWrapper(null));
        widgets.add(LabelWidget(label: "choose preference",child: BlocProvider(create: (_)=>PreferenceCubit.empty()..loadPreferences(context, currentClient),child: pref,)));
        widgets.add(PreferenceButton(selector: pref, onClicked: (value)
        {
          if(value!=null)
          {
            setState(() {
              filterCreator=ProductFilterCreator(reference: ItemWrapper(ProductFilter.formPreference(value)));
            });
          }
        }, child:const Text("Activate preference")));
    }
    widgets.add(super.build(context));
    return Column(mainAxisAlignment: MainAxisAlignment.center,children: widgets,);
    });
  }

  @override
  ListCubit<Product> providerCubit=ProductCubit();
  @override 
  Widget putWidgets(Widget listWidget,Widget filterWidget)
  {
    int listFlex=9,filterFlex=5;
    double sum=listFlex+filterFlex.toDouble();
    double pixelPerFlex=250/filterFlex;
    return LayoutBuilder(
      builder: (context,constraints) {
        if(constraints.maxWidth<pixelPerFlex*sum)
        {
          return Center(
            child: Align(
             alignment: Alignment.centerRight,
             child: Row(mainAxisAlignment: MainAxisAlignment.end,
             children: [Expanded(flex: listFlex,child: StandardDecorator(child: listWidget)),Expanded(flex: filterFlex,child: StandardDecorator(child: filterWidget))],
              ),
           ),
         );
        }
        else 
        {
          return Center(
            child: Align(
             alignment: Alignment.centerRight,
             child: Row(mainAxisAlignment: MainAxisAlignment.end,
             children: [
              Expanded(flex: listFlex,child: Center(child: SizedBox(width: pixelPerFlex*listFlex,child: StandardDecorator(child: listWidget)))),
              Expanded(flex: filterFlex,child: Center(child: SizedBox(width: pixelPerFlex*filterFlex,child: StandardDecorator(child: filterWidget))))],
              ),
           ),
         );
        }
      }
    );
  }
  @override
  Widget getObjectWidget(Product obj, BuildContext context) {
    return obj.clickableIconWidget(context);
  }
}
//Producer screen
class ProductEditScreen extends SearchScreen<Product> {
  final Producer producer;
  const ProductEditScreen({super.key,required this.producer});
  ProductEditScreen.fromCubit({super.key,required SessionCubit cubit}):producer=cubit.state.currentProducer!;

  @override
  State<SearchScreen<Product>> createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends _ProductSearchScreenState {
  ProductEditScreen get myWidget=>widget as ProductEditScreen;
  @override
  Widget build(BuildContext context) {
    columns=1;
    (filter as ProductFilter).producer=myWidget.producer;
    return Column(
      children: [
        super.build(context),
        DialogButton<Product>(
          creator: ProductCreator(reference: ItemWrapper(Product.empty()..producer=myWidget.producer),),
          onFinished: (value){
            setState(() {
            (providerCubit as ProductCubit).addProduct(value, context);
            refresh();
            });
            },
          child:const Text("Add new product"))
      ],
    );
  }
  
  @override
  Widget getObjectWidget(Product obj, BuildContext context) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: 
            [
              GestureDetector(child: obj.clickableIconWidget(context),
              onTap: (){
                Navigator.push(context, widgetShower(ProductAndOpinionWidget(product: obj)));
              },
              ),
              DialogButton<Product>
              (
                creator: 
                ProductCreator(reference: ItemWrapper(Product.clone(obj)),),
                onFinished: (product) { (providerCubit as ProductCubit).editProduct(obj, product, context);},
                child: const Text("edit"),
              ),
              DialogButton
              (
                creator: ConfirmCreator(),
                onFinished: (product) { 
                  setState(() {
                    (providerCubit as ProductCubit).removeProduct(obj, context);
                    lastData=null;
                    providerCubit.loadData(from,from+count,filter,context,reset: true);
                  });
                  },
                child: const Text("delete"),
              ),
              TextButton(
                onPressed: () async {
                 DateTime? dateTime = await showOmniDateTimePicker(context: context,
                 type: OmniDateTimePickerType.date,
                 firstDate: obj.promotionUntil.isAfter(DateTime.now())?obj.promotionUntil:DateTime.now(),
                 lastDate: (obj.promotionUntil.isAfter(DateTime.now())?obj.promotionUntil:DateTime.now()).add(const Duration(days: 356*20)),
                 initialDate: obj.promotionUntil.isAfter(DateTime.now())?obj.promotionUntil:DateTime.now(),
                 );
                Product edit=Product.clone(obj);
                if(dateTime!=null)
                {
                  edit.promotionUntil=dateTime;
                  setState(() {
                    SessionCubit.fromContext(context).database.productDatabse.editProduct(obj, edit);
                    obj.promotionUntil=dateTime;
                  });
                }
                },
                child: PromotionWidget(dateTime: obj.promotionUntil)),

            ],
          );
  }
}
class FavouriteProductSearchScreen extends SearchScreen<Product> {
  const FavouriteProductSearchScreen({super.key});
  @override
  SearchScreenState<Product> createState() => _FavouriteProductSearchScreenState();
}
class _FavouriteProductSearchScreenState extends _ProductSearchScreenState
{
  ListCubit<Product>? _listCubit;
  @override
  ListCubit<Product> get providerCubit
  {
    _listCubit ??= FavouriteProductsCubit.empty();
    return _listCubit!;
  }
  @override
  set providerCubit(ListCubit<Product> value)=>_listCubit=value;
}
