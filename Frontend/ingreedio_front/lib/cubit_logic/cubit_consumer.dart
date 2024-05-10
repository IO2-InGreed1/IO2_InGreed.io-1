import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ingreedio_front/cubit_logic/ingredient_cubit.dart';
import 'package:ingreedio_front/cubit_logic/preference_cubit.dart';
import 'package:ingreedio_front/cubit_logic/session_cubit.dart';
import 'package:ingreedio_front/cubit_logic/session_data.dart';
import 'package:ingreedio_front/logic/products.dart';
import 'package:ingreedio_front/logic/users.dart';
import 'package:ingreedio_front/ui/common_ui_elements.dart';

class CubitConsumer<T> extends StatelessWidget {
  const CubitConsumer({super.key,this.showLoadingScreen=true, required this.child});
  final Widget Function(BuildContext,List<T>?) child;
  final bool showLoadingScreen;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Cubit<List<T>?>,List<T>?>(builder: (context,items){
      if(items==null&&showLoadingScreen)
      {
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child:  LoadingWidget(),
        );
      }
      return child(context,items);
    },);
  }
}
class IngredientConsumer extends CubitConsumer<Ingredient>
{
  const IngredientConsumer({super.key, required super.child,super.showLoadingScreen});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IngredientCubit,List<Ingredient>?>(builder: (context,items){
      if(items==null&&showLoadingScreen)
      {
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: LoadingWidget(),
        );
      }
      return child(context,items);
    },);
  }
}
class PreferenceConsumer extends CubitConsumer<Preference>
{
  const PreferenceConsumer({super.key, required super.child,super.showLoadingScreen});
    @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreferenceCubit,List<Preference>?>(builder: (context,items){
      if(items==null&&showLoadingScreen)
      {
        return const Padding(
          padding:EdgeInsets.all(8.0),
          child:LoadingWidget(),
        );
      }
      return child(context,items);
    },);
  }
}
class SessionDataConsumer extends StatelessWidget
{
  final Widget Function(BuildContext,SessionData) child;
  final bool showLoadingScreen;
  const SessionDataConsumer({super.key, required this.child,this.showLoadingScreen=true});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit,SessionData>(builder: (context,item){
      return child(context,item);
    },);
  }
}