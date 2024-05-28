import 'package:flutter/material.dart';
import 'package:ingreedio_front/logic/users.dart';
import 'package:ingreedio_front/ui/common_ui_elements.dart';
import 'package:ingreedio_front/ui/screens/moderator_screen.dart';
import 'package:ingreedio_front/ui/widgets/getAppBar_widget.dart';
import 'package:ingreedio_front/ui/widgets/terminal_widget.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key, required this.admin});
  final User admin;

  Widget getBody(BuildContext context,{bool withClientProfile=true})
  {
            return Row(
                children: [
                  Expanded(flex: 3,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          reportedItemsWidget(context),
                          StandardDecorator(
                                    color: Theme.of(context).colorScheme.secondary,
                                    child:const TerminalScreen()
                                  ),
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
                              admin.userProfileWidget,
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
        return Scaffold(appBar: getAppBar(context,withClientProfile: !withProfile,buttonSubmenu: !withProfile,user: admin),
        body: getBody(context,withClientProfile: withProfile),);
      }
    );
  }
}