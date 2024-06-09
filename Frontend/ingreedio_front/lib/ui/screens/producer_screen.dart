import 'package:flutter/material.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/logic/users.dart';
import 'package:ingreedio_front/ui/common_ui_elements.dart';
import 'package:ingreedio_front/ui/screens/product_search_screen.dart';
import 'package:ingreedio_front/ui/widgets/user_widget.dart';

class ProducerScreen extends StatelessWidget {
  const ProducerScreen({super.key, required this.producer});
  final Producer producer;

  Widget getBody(BuildContext context,{bool withClientProfile=true})
  {
    //return const SizedBox(width: 1,height: 1,);
    
    return Row(
      children: [
        Expanded(flex: 3,child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15,),
              StandardDecorator(
                color: Theme.of(context).colorScheme.secondary,
                child: SizedBox(
                  width:750,
                  child: LabelWidget(
                    label: "My products",
                    isHorizontal: false,
                    child: ProductEditScreen(producer: producer,),),
                ),
              ),
              const SizedBox(height: 15,)
            ],
          ))),
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
                                    producer.userProfileWidget,
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
    //return Scaffold(appBar: getAppBar(context),body: getBody(context),);
    return LayoutBuilder(
      builder: (context,constraints) {
        bool withProfile=constraints.maxWidth>870;
        return Scaffold(appBar: getUserAppBar(context,withClientProfile: !withProfile,buttonSubmenu: !withProfile,user: producer),
        body: getBody(context,withClientProfile: withProfile),);
      }
    );
  }
}