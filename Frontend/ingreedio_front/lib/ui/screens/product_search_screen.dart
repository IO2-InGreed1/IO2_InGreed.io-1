import 'package:flutter/material.dart';
import 'package:ingreedio_front/creators/empty_filter_creator.dart';
import 'package:ingreedio_front/cubit_logic/cubit_consumer.dart';
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
import 'package:ingreedio_front/ui/widgets/datetime_widget.dart';
import 'package:ingreedio_front/ui/screens/search_screen.dart';
class ProductSearchScreen extends SearchScreen<Product> {
  const ProductSearchScreen({super.key});
  @override
  SearchScreenState<Product> createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends SearchScreenState<Product> {
  bool get showPreferences=>true;
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
    if(currentClient!=null&&showPreferences)
    {
      var pref=PreferenceSelector(reference: ItemWrapper(null));
        widgets.add(const SizedBox(height: 15,));
        widgets.add(LabelWidget(isHorizontal: false,label: "choose preference",child: pref));
        widgets.add(const SizedBox(height: 10,));
        widgets.add(PreferenceButton(selector: pref, onClicked: (value)
        {
          if(value!=null)
          {
            setState(() {
              filterCreator=ProductFilterCreator(reference: ItemWrapper(ProductFilter.fromPreference(value)));
            });
          }
        }, child:const Text("Activate preference")));
    }
    widgets.add(const SizedBox(height: 15,));
    widgets.add(super.build(context));
    widgets.add(const SizedBox(height: 15,));
    return Column(mainAxisAlignment: MainAxisAlignment.center,children: widgets,);
    });
  }

  @override
  ListCubit<Product> providerCubit=ProductCubit();
  @override 
  Widget putWidgets(Widget listWidget,Widget filterWidget)
  {
    int listFlex=3,filterFlex=1;
    double sum=listFlex+filterFlex.toDouble();
    double pixelPerFlex=300/filterFlex;
    return LayoutBuilder(
      builder: (context,constraints) {
        if(constraints.maxWidth<(1/2)*pixelPerFlex*sum)
        {
          return Column(mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(height: 15,),
            StandardDecorator(child: filterWidget),
            const SizedBox(height: 15,),
            StandardDecorator(child: listWidget),
            const SizedBox(height: 15,)
            ],
           );
        }
        if(constraints.maxWidth<pixelPerFlex*sum)
        {
          return Row(mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(width: 15,),
            Expanded(flex: listFlex,child: StandardDecorator(child: listWidget)),
            const SizedBox(width: 15,),
            Expanded(flex: filterFlex,child: Align(alignment: Alignment.topRight,child: StandardDecorator(child: filterWidget))),
            const SizedBox(width: 15,)
            ],
           );
        }
        else 
        {
          return Row(mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(width: 15,),
           Expanded(flex: listFlex,child: Center(child: SizedBox(width: pixelPerFlex*listFlex,child: StandardDecorator(child: listWidget)))),
           const SizedBox(width: 15,),
           Expanded(flex: filterFlex,child: Align(alignment: Alignment.topRight,child: SizedBox(width: pixelPerFlex*filterFlex,child: StandardDecorator(child: filterWidget)))),
           const SizedBox(width: 15,)],
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
  Widget putWidgets(Widget listWidget,Widget filterWidget)
  {
    return listWidget;
  }
  @override
  Widget build(BuildContext context) {
    columns=1;
    (filter as ProductFilter).producer=myWidget.producer;
    return Column(
      children: [
        super.build(context),
        DialogButton<Product>(
          creator: ProductCreator(reference: ItemWrapper(Product.empty()..producer=myWidget.producer),),
          onFinished: (value) async{
            setState(() {
            (providerCubit as ProductCubit).addProduct(value, context);
            refresh();
            });
            },
          child:const Text("Add new product")),
          const SizedBox(height: 15,),
          reloadButton
      ],
    );
  }
  
  @override
  Widget getObjectWidget(Product obj, BuildContext context) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: 
            [
              obj.clickableIconWidget(context),
              // GestureDetector(child: obj.clickableIconWidget(context),
              // onTap: (){
              //   Navigator.push(context, widgetShower(ProductAndOpinionWidget(product: obj)));
              // },
              // ),
              Column(
                children: [
                  Row(
                    children: [
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
                    ],
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
                    SessionCubit.fromContext(context).database.productDatabase.editProduct(obj, edit);
                    obj.promotionUntil=dateTime;
                  });
                }
                },
                child: PromotionWidget(dateTime: obj.promotionUntil)),
                ],
              ),
              

            ],
          );
  }
}
class FavouriteProductSearchScreen extends SearchScreen<Product> {
  const FavouriteProductSearchScreen({super.key}):super(rows:4);
  @override
  SearchScreenState<Product> createState() => _FavouriteProductSearchScreenState();
}
class _FavouriteProductSearchScreenState extends _ProductSearchScreenState
{
  @override 
  bool get showPreferences=>false;
  ListCubit<Product>? _listCubit;
  @override
  ListCubit<Product> get providerCubit
  {
    _listCubit ??= FavouriteProductsCubit.empty();
    return _listCubit!;
  }
  @override 
  Widget putWidgets(Widget listWidget,Widget filterWidget)
  {
    return Column(
      children: [
        StandardDecorator(color: Colors.transparent,child: listWidget),
        reloadButton
      ],
    );
  }
  @override Widget getListWidget(List<Product> list, BuildContext context) {
    if(lastData!=null&&lastData!.data.isEmpty)
    {
      return const Column
        (
          children: 
          [
            Text("Search for your favourite products"),
            SearchButton(),
          ],
        );
    }
    return super.getListWidget(list, context);
  }
  @override
  set providerCubit(ListCubit<Product> value)=>_listCubit=value;
}

class ReportedProductSearchScreen extends SearchScreen<Product> {
  const ReportedProductSearchScreen({super.key,super.rows=3});

  @override
  SearchScreenState<Product> createState() => _ReportedProductSearchScreenState();
}

class _ReportedProductSearchScreenState extends SearchScreenState<Product> 
{
  @override 
  Widget build(BuildContext context)
  {
    columns=1;
    return super.build(context);
  }
  @override
  Filter<Product> filter=EmptyFilter<Product>();

  @override
  Creator<Filter<Product>> filterCreator=EmptyFilterCreator(reference: ItemWrapper(EmptyFilter<Product>()));

  @override
  ListCubit<Product> providerCubit=ReportedProductCubit.empty();
  @override
  Widget putWidgets(Widget listWidget,Widget filterWidget)
  {
    return Column(mainAxisAlignment: MainAxisAlignment.center,children: [reloadButton,listWidget]);
  }
  @override
  Widget getObjectWidget(Product obj, BuildContext context) {
    return Row(children: [
      obj.clickableIconWidget(context),
      Column( children: [
        ConfirmDialogButton(onFinished: (value) 
      {
        (providerCubit as ReportedProductCubit).removeProduct(obj, context);
      },
      child: const Text("Delete"),),
      ConfirmDialogButton(onFinished: (value) 
      {
        SessionCubit.fromContext(context).database.productDatabase.setProductReportState(obj,state: false);
      },
      child: const Text("Dismiss"),),
    ])
    ]);
  }
  
}