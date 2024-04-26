import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ingreedio_front/logic/products.dart';
import 'package:ingreedio_front/ui/common_ui_elements.dart';

class OpinionWidget extends StatelessWidget {
  const OpinionWidget({super.key,required this.opinion});
  final Opinion opinion;
  @override
  Widget build(BuildContext context) {
    Color c=Colors.red;
    if(opinion.score>1) c=Colors.orange;
    if(opinion.score>2) c=Colors.yellow;
    if(opinion.score>3) c=Colors.greenAccent;
    if(opinion.score>4) c=Colors.green;
    return StandardDecorator(
      color: c,
      child: Column(
        children: [
          opinion.author.clientWidget,
          RatingBarIndicator(
          rating: opinion.score,
          itemBuilder: (context, index) => const Icon(
           Icons.star,
           color: Colors.amber,
      ),
      itemCount: 5,
      itemSize: 30.0,
      direction: Axis.horizontal,
      ),
          Text(opinion.text,maxLines: null),
        ],
      ),
    );
  }
}