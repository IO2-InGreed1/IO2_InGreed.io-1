import 'package:flutter/material.dart';
import 'package:ingreedio_front/cubit_logic/cubit_consumer.dart';
import 'package:ingreedio_front/cubit_logic/preference_cubit.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/creators/preference_creator.dart';
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
      filterCreator=ProductFilterCreator(reference: ItemWrapper(filter.clone() as ProductFilter))..item.preference=[Ingredient.fromAllData(iconURL: "a", id: 1, name: "XD1")];
    }
    Client? currentClient=SessionCubit.fromContext(context).state.currentClient;
    List<Widget> widgets=List.empty(growable: true);
    if(currentClient!=null)
    {
      var pref=PreferenceSelector(reference: ItemWrapper(null), 
        );
        widgets.add(pref);
        widgets.add(DialogButton<Preference>(creator: 
        PreferenceCreator(
        reference:ItemWrapper(Preference.forClient(currentClient),),
        ), 
        onFinished: (value)
        {
          setState(() {
            PreferenceCubit.fromContext(context).addPreference(context,value);
          });
        }, 
        child:const Text("add new preference")));
        widgets.add(PreferenceButton(selector: pref, onClicked: (value)
        {
          if(value!=null)
          {
            setState(() {
              filterCreator=ProductFilterCreator(reference: ItemWrapper(ProductFilter.formPreference(value)));
            });
          }
        }, child:const Text("Activate preference")));

        widgets.add(DialogEditButton<Preference>(creator: 
        PreferenceCreator(
        reference:ItemWrapper(Preference.forClient(currentClient),),
        ), 
        onFinished: (value)
        {
          setState(() {
            value.client=currentClient;
            PreferenceCubit.fromContext(context).editPreference(context,pref.item!,value);
          });
        }, 
        onClicked: () {
          if(pref.item==null) return null;
          return pref.item!.clone();
        },
        child:const Text("edit preference")));
        widgets.add(PreferenceButton(selector: pref, onClicked: (value)
        {
          if(value!=null)
          {
            setState(() {
            PreferenceCubit.fromContext(context).removePreference(context,pref.item!);
          });
          }
        }, child:const Text("Delete preference")));
    }
    widgets.add(super.build(context));
    return Column(mainAxisAlignment: MainAxisAlignment.center,children: widgets,);
    });
  }

  @override
  ListCubit<Product> providerCubit=ProductCubit.empty();

  @override
  Widget getListWidget(List<Product> obj, BuildContext context) {
    return expandableProductList(obj, context);
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
  Widget getListWidget(List<Product> obj, BuildContext context) {
    return Column(
      children: obj.map((e)
        {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: 
            [
              GestureDetector(child: e.iconWidget,
              onTap: (){
                Navigator.push(context, widgetShower(ProductAndOpinionWidget(product: e)));
              },
              ),
              DialogButton<Product>
              (
                creator: 
                ProductCreator(reference: ItemWrapper(Product.clone(e)),),
                onFinished: (product) { (providerCubit as ProductCubit).editProduct(e, product, context);},
                child: const Text("edit"),
              ),
              DialogButton
              (
                creator: ConfirmCreator(),
                onFinished: (product) { 
                  setState(() {
                    (providerCubit as ProductCubit).removeProduct(e, context);
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
                 firstDate: e.promotionUntil.isAfter(DateTime.now())?e.promotionUntil:DateTime.now(),
                 lastDate: (e.promotionUntil.isAfter(DateTime.now())?e.promotionUntil:DateTime.now()).add(const Duration(days: 356*20)),
                 initialDate: e.promotionUntil.isAfter(DateTime.now())?e.promotionUntil:DateTime.now(),
                 );
                Product edit=Product.clone(e);
                if(dateTime!=null)
                {
                  edit.promotionUntil=dateTime;
                  setState(() {
                    SessionCubit.fromContext(context).state.database.productDatabse.editProduct(e, edit);
                    e.promotionUntil=dateTime;
                  });
                }
                },
                child: PromotionWidget(dateTime: e.promotionUntil)),

            ],
          );
        } 
      ).toList(),
    );
  }
}