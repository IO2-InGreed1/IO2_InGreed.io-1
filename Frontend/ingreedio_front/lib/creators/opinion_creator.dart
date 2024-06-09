import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ingreedio_front/creators/common_creators.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/logic/products.dart';
class DoubleRatingCreator extends Creator<double> {
  const DoubleRatingCreator({this.minValue=0,this.maxValue=5,super.key, required super.reference,super.onChanged});
  final double minValue,maxValue;
  @override
  State<DoubleRatingCreator> createState() => _DoubleRatingCreatorState();
  
  @override
  Creator<double> getInstance({Key? key, Function(double p1) onChanged = doNothing, required ItemWrapper<double> reference}) {
    return DoubleRatingCreator(reference: reference,onChanged: onChanged,key: key,maxValue: maxValue,minValue: minValue,);
  }
}
class _DoubleRatingCreatorState extends State<DoubleRatingCreator> {
  @override
  Widget build(BuildContext context) {
    if(widget.item>widget.maxValue) widget.item=widget.maxValue;
    if(widget.item<widget.minValue) widget.item=widget.minValue;
    return RatingBar.builder(
   initialRating: widget.item,
   minRating: widget.minValue,
   direction: Axis.horizontal,
   allowHalfRating: true,
   itemCount: (widget.maxValue-widget.minValue).toInt(),
   itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
   itemBuilder: (context, _) => const Icon(
     Icons.star,
     color: Colors.amber,
   ),
   onRatingUpdate: (rating) {
     widget.item=rating;
   },
);
  }
}

class OpinionCreator extends Creator<Opinion> {
  const OpinionCreator({super.key, required super.reference,super.onChanged});

  @override
  State<OpinionCreator> createState() => _OpinionCreatorState();
  
  @override
  Creator<Opinion> getInstance({Key? key, Function(Opinion p1) onChanged = doNothing, required ItemWrapper<Opinion> reference}) {
    return OpinionCreator(reference: reference,key: key,onChanged: onChanged,);
  }
}

class _OpinionCreatorState extends State<OpinionCreator> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LabelWidget(
          label: "Opinion: "
          ,child: StringCreator(item: widget.item.text,
          onChanged: (value){widget.item.text=value;},
          allowMultiline: true,),
        ),
        LabelWidget(isHorizontal: false,label: "Score: ",child: DoubleRatingCreator(reference:ItemWrapper(widget.item.score),onChanged: (value){widget.item.score=value;},))
      ],
    );
  }
}