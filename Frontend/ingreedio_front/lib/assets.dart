import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Assets
{
  static Image? _inGreedIcon;
  static Image? _placeholderImage;
  static Widget get loadingWidget
  {
    return Center(child: LoadingAnimationWidget.discreteCircle(color: Colors.green, size: 70));
  }
  static Image get inGreedIcon
  {
    _inGreedIcon ??= const Image(image: AssetImage('assets/in_greed_logo.png'));
    return _inGreedIcon!;
  }
  static Image get placeholderImage
  {
    _placeholderImage ??= const Image(image: AssetImage('assets/placeholder_image.png'));
    return _placeholderImage!;
  }
  static Widget resizedInGreedIcon({double width=60})
  {
    return SizedBox(width: width,child: inGreedIcon);
  }
}