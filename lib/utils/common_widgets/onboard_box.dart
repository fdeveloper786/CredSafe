import 'package:credsafe/utils/constants/constants_onboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardBox extends StatelessWidget {
  const OnBoardBox({super.key,required this.svgName,required this.title, required this.description});
  final String svgName;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: boxWhiteColor,
          border: Border.all(
            width: 0.0,
            color: boxWhiteColor,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                height: 350,
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: SvgPicture.asset(
                    svgName
                )
            ),
             SizedBox(
              height: 200,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        title,
                        style: pageTitleStyle,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Text(
                        description,
                        style: pageInfoStyle,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}