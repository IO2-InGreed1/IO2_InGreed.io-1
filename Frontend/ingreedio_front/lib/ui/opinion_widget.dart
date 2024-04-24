import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ingreedio_front/products.dart';

class OpinionWidget extends StatelessWidget {
  const OpinionWidget({super.key,required this.opinion});
  final Opinion opinion;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        opinion.author.clientWidget,
        RatingBarIndicator(
        rating: opinion.score,
        itemBuilder: (context, index) => const Icon(
         Icons.star,
         color: Colors.amber,
    ),
    itemCount: 5,
    itemSize: 50.0,
    direction: Axis.horizontal,
),
        Text(opinion.text,maxLines: null),
      ],
    );
  }
}