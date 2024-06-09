import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/cubit_logic/session_cubit.dart';
import 'package:ingreedio_front/logic/products.dart';
import 'package:ingreedio_front/ui/common_ui_elements.dart';
class OpinionReportCreator extends Creator<bool> {
  final Opinion opinion;
  const OpinionReportCreator({super.key,required this.opinion, required super.reference,super.onChanged});

  @override
  State<OpinionReportCreator> createState() => _OpinionReportCreatorState();
  
  @override
  Creator<bool> getInstance({Key? key, Function(bool p1) onChanged = doNothing, required ItemWrapper<bool> reference}) {
    return OpinionReportCreator(opinion: opinion, reference: reference,onChanged: onChanged,key: key,);
  }
}

class _OpinionReportCreatorState extends State<OpinionReportCreator> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Text("Do you want to report this opinion?"),
      widget.opinion.widget
    ],);
  }
}
class OpinionWidget extends StatelessWidget {
  const OpinionWidget({super.key,required this.opinion,this.showReportButton=false});
  final bool showReportButton;
  final Opinion opinion;
  @override
  Widget build(BuildContext context) {
    Color c=Colors.red;
    if(opinion.score>1) c=Colors.orange;
    if(opinion.score>2) c=Colors.yellow;
    if(opinion.score>3) c=Colors.greenAccent;
    if(opinion.score>4) c=Colors.green;
    Widget reportButton=DialogButton(creator: OpinionReportCreator(opinion: opinion,reference: ItemWrapper(true),), onFinished: (value){
      SessionCubit.fromContext(context).database.opinionDatabase.setOpinionReport(opinion);
    }, child: const Text("report"));
    try
    {
      var client= SessionCubit.fromContext(context).state.currentClient;
      if(client!=null)
      {
        if(client.id==opinion.author.id)
        {
          reportButton=DialogButton(creator: ConfirmCreator(), onFinished: (value)=>
          SessionCubit.fromContext(context).database.opinionDatabase.removeOpinion(opinion), child: const Text("delete"));
        }
      }
    }
    catch(e)
    {
      //
    }
    List<Widget> widgets=showReportButton?[opinion.author.userWidget,reportButton]:[opinion.author.userWidget];
    return StandardDecorator(
      color: c,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widgets
          ),
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
          OpinionText(text:opinion.text),
        ],
      ),
    );
  }
}
class OpinionText extends StatelessWidget {
  final String text;
  final int maxLength;
  const OpinionText({super.key, required this.text, this.maxLength=20});

  @override
  Widget build(BuildContext context) {
    bool isTextLong = text.length > maxLength;
    String displayText = isTextLong ? '${text.substring(0, maxLength)}...' : text;
    if(isTextLong)
    {
      return Tooltip(
      message: text,
      child: Text(displayText),
    );
    }
    else
    {
      return Text(text);
    }
  }
}