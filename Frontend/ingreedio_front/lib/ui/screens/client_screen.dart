import 'package:flutter/material.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/cubit_logic/preference_cubit.dart';
import 'package:ingreedio_front/logic/users.dart';
import 'package:ingreedio_front/ui/common_ui_elements.dart';
import 'package:ingreedio_front/ui/preferences_menager.dart';
import 'package:ingreedio_front/ui/screens/product_search_screen.dart';
import 'package:ingreedio_front/ui/widgets/getAppBar_widget.dart';


class ClientScreen extends StatelessWidget {
  const ClientScreen({super.key, required this.client});
  final Client client;
  Widget managePreferencesButton(BuildContext context)
  {
    return TextButton(
      onPressed: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Scaffold(appBar: getStandardAppBar(context),body: PreferenceMenager(),)));
      }, child: const Text("manage preferences"));
  }

  Widget getBody(BuildContext context,{bool withClientProfile=true})
  {
        return Row(
            children: [
              Expanded(flex: 3,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: managePreferencesButton(context)
                    ),
                    StandardDecorator(
                      color: Theme.of(context).colorScheme.secondary,
                      child: const SizedBox(width:800,child: LabelWidget(
                        isHorizontal: false,
                        label: "Favourite Products:",
                        child: FavouriteProductSearchScreen()))
                        ,
                    ),
                  ],
                ),
              ),
              withClientProfile?Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FractionallySizedBox(
                          heightFactor: 0.9,
                          child: Container(
                            color: Colors.yellow[100],
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 20),
                                    client.userProfileWidget,
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ):const SizedBox(),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    if(PreferenceCubit.fromContext(context).state==null)
    {
      PreferenceCubit.fromContext(context).loadPreferences(context,client);
    }
    //return Scaffold(appBar: getAppBar(context),body: getBody(context),);
    return LayoutBuilder(
      builder: (context,constraints) {
        bool withProfile=constraints.maxWidth>825;
        return Scaffold(appBar: getAppBar(context,withClientProfile: !withProfile,buttonSubmenu: !withProfile,user: client),
        body: getBody(context,withClientProfile: withProfile),);
      }
    );
  }
}