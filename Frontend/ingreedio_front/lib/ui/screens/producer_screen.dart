import 'package:flutter/material.dart';
import 'package:ingreedio_front/logic/users.dart';
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
        SingleChildScrollView(child: Expanded(flex:3,
        child: Center(
          child: SizedBox(
            width: 600,
            child: Center(child: ProductEditScreen(producer: producer,))),
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
        bool withProfile=constraints.maxWidth>825;
        return Scaffold(appBar: getUserAppBar(context,withClientProfile: !withProfile,buttonSubmenu: !withProfile,user: producer),
        body: getBody(context,withClientProfile: withProfile),);
      }
    );
  }
}