import 'package:flutter/material.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/logic/admins.dart';
import 'package:ingreedio_front/ui/common_ui_elements.dart';
import 'package:ingreedio_front/ui/screens/opinion_search_screen.dart';
import 'package:ingreedio_front/ui/screens/product_search_screen.dart';
import 'package:ingreedio_front/ui/widgets/getAppBar_widget.dart';

class ModeratorScreen extends StatelessWidget {
  const ModeratorScreen({super.key, required this.moderator});
  final Moderator moderator;

  Widget getBody(BuildContext context,{bool withClientProfile=true})
  {
        return Row(
            children: [
              Expanded(flex: 3,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      reportedItemsWidget(context),
                    ],
                  ),
                )
              ),
              withClientProfile?Expanded(
                flex: 1,
                child: Container(
                  color: Colors.yellow[100],
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          moderator.userProfileWidget,
                        ],
                      ),
                    ),
                  ),
                ),
              ):const SizedBox(),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    //return Scaffold(appBar: getAppBar(context),body: getBody(context),);
    return LayoutBuilder(
      builder: (context,constraints) {
        bool withProfile=constraints.maxWidth>825;
        return Scaffold(appBar: getAppBar(context,withClientProfile: !withProfile,buttonSubmenu: !withProfile,user: moderator),
        body: getBody(context,withClientProfile: withProfile),);
      }
    );
  }
}
Widget reportedItemsWidget(BuildContext context)
{
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  StandardDecorator(
                                    color: Theme.of(context).colorScheme.secondary,
                                    child: const SizedBox(width:250, height: 450, 
                                    child: LabelWidget(
                                      isHorizontal: false,
                                      label: "Reported opinions",
                                      child: Expanded(child: ReportedOpinionSearchScreen())))
                                      ,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  StandardDecorator(
                                    color: Theme.of(context).colorScheme.secondary,
                                    child: const SizedBox(height: 450, 
                                    child: LabelWidget(
                                      isHorizontal: false,
                                      label: "Reported products",
                                      child: Expanded(child: ReportedProductSearchScreen())))
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
}