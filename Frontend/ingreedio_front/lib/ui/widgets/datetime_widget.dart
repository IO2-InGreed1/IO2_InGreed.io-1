import 'package:flutter/cupertino.dart';

class DateTimeWWidget extends StatelessWidget {
  const DateTimeWWidget({super.key, required this.dateTime});
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Text("${dateTime.day}-${dateTime.month}-${dateTime.year}");
  }
}
class PromotionWidget extends StatelessWidget {
  const PromotionWidget({super.key, required this.dateTime});
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) 
  {
    if(dateTime.isAfter(DateTime.now())) 
    {
      return Text("Promotion Until: ${formatWithLeadingZero(dateTime.day)}-${formatWithLeadingZero(dateTime.month)}-${dateTime.year}");
    } 
    else 
    {
      return const Row(
        children: [ SizedBox(width: 45,),
          Text("No promotion"),
          SizedBox(width: 45,)
        ],
      );
    }
  }
  String formatWithLeadingZero(int value) {
  return value.toString().padLeft(2, '0');
}
}