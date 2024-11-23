import 'package:credsafe/utils/common_widgets/common_text.dart';
import 'package:credsafe/utils/constants/app_decoration.dart';
import 'package:credsafe/utils/sizes/size.dart';
import 'package:custom_gradient_button/custom_gradient_button.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String? btnLabel;
  Function? onTap;
  final Color? firstColor;
  final Color? secondColor;
  final double? height;
  final double? width;

  AppButton({super.key, this.btnLabel, this.onTap,this.firstColor,this.secondColor,this.height,this.width});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomGradientButton(
        height: height ?? h50,
        width: width ?? w250,
        firstColor: firstColor ?? Colors.greenAccent,
        secondColor: secondColor ?? Colors.blueAccent,
        method: onTap,
        child: CommonText(
          text: btnLabel ?? '',
          textStyle: AppStyle.txtWhite20,
        )
      ),
    );
  }
}