import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class Assets
{
  static Image? _inGreedIcon;
  static Image? _placeholderImage;
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
class ImageData
{
  XFile? file;
  Image? _image;
  void pickImage() async
  {
    final XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedFile!=null) file=pickedFile;
  }
  Image get image
  {
    if(file==null) return Assets.placeholderImage;
    _image??=Image.file(File(file!.path),);
    return _image!;
  }
}