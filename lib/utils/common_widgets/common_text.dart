import 'package:credsafe/utils/constants/app_decoration.dart';
import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  const CommonText({super.key, required this.text, this.textStyle,this.textAlign});
  final String text;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return  Text(
      text,
      style: textStyle ?? AppStyle.txtBlack20,
      textAlign: textAlign ?? TextAlign.left,
    );
  }
}