import 'package:flutter/material.dart';

class Assets
{
  static Image? _inGreedIcon;
  static Image get inGreedIcon
  {
    _inGreedIcon ??= const Image(image: AssetImage('assets/inGreedLogo.png'));
    return _inGreedIcon!;
  }
  static Widget resizedInGreedIcon({double width=60})
  {
    return SizedBox(width: width,child: inGreedIcon);
  }
}