import 'dart:developer';

import 'package:credsafe/screens/auth_wrapper/auth_wrapper.dart';
import 'package:credsafe/utils/common_widgets/common_text.dart';
import 'package:credsafe/utils/constants/app_color.dart';
import 'package:credsafe/utils/constants/app_decoration.dart';
import 'package:credsafe/utils/constants/constants_onboard.dart';
import 'package:credsafe/utils/common_widgets/onboard_box.dart';
import 'package:credsafe/utils/constants/app_constants.dart';
import 'package:credsafe/utils/constants/image_constant.dart';
import 'package:credsafe/utils/sizes/size.dart';
import 'package:flutter/material.dart';
import 'package:onboarding/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late int index;
  final activePainter = Paint();
  final inactivePainter = Paint();

  static const width = w100;
  @override
  void initState() {
    super.initState();
    index = 0;
    activePainter.color = Colors.grey;
    activePainter.strokeWidth = 1;
    activePainter.strokeCap = StrokeCap.round;
    activePainter.style = PaintingStyle.fill;

    inactivePainter.color = pageImageColor;
    inactivePainter.strokeWidth = 1;
    inactivePainter.strokeCap = StrokeCap.round;
    inactivePainter.style = PaintingStyle.stroke;
  }

  SizedBox _skipButton({void Function(int)? setIndex}) {
    return SizedBox(
      width: width,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Material(
          borderRadius: defaultSkipButtonBorderRadius,
          color: defaultSkipButtonColor,
          child: InkWell(
            borderRadius: defaultSkipButtonBorderRadius,
            onTap: () {
              if (setIndex != null) {
                index = 2;
                setIndex(2);
                if(index == 2) {
                  activePainter.color = AppColor.hexBlue;
                }else {
                  activePainter.color = Colors.grey;
                }
              }
            },
            child:  Padding(
              padding: defaultSkipButtonPadding,
              child: CommonText(
                text: skipLbl,
                textStyle: AppStyle.txtWhite16
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox get _signupButton {
    return SizedBox(
      width: width,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Material(
          borderRadius:defaultProceedButtonBorderRadius,
          color: AppColor.hexBlue,
          child: InkWell(
            borderRadius: defaultProceedButtonBorderRadius,
            onTap: () async {
              log('signup button');
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool('isFirstTime', false);

              // Navigate to authentication screen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AuthWrapper()),
              );
            },
            child:  Padding(
              padding: defaultProceedButtonPadding,
              child: CommonText(
                text: signUp,
                textStyle: AppStyle.txtWhite16,
              )
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Onboarding(
          swipeableBody: onboardingPagesList,
          startIndex: 0,
          onPageChanges: (_, __, currentIndex, sd) {
            index = currentIndex;
            if(index == 2) {
              activePainter.color = AppColor.hexBlue;
            }else {
              activePainter.color = Colors.grey;
            }
          },
          buildFooter: (context, dragDistance, pagesLength, currentIndex, setIndex, sd) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: boxWhiteColor,
                border: Border.all(
                  width: w0,
                  color: background,
                ),
              ),
              child: ColoredBox(
                color: boxWhiteColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: p20, vertical: p40
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      index != pagesLength - 1
                          ? _skipButton(setIndex: setIndex)
                          : _signupButton,
                      Padding(
                        padding: const EdgeInsets.only(right: p45),
                        child: Indicator<SquarePainter>(
                          painter: SquarePainter(
                            currentPageIndex: index,
                            pagesLength: pagesLength,
                            netDragPercent: dragDistance,
                            activePainter: activePainter,
                            inactivePainter: inactivePainter,
                            slideDirection: sd,
                            space: p5,
                            width: p10,
                            showAllActiveIndicators: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  final onboardingPagesList = [
    const OnBoardBox(
      title: title1,
      description: description1,
      svgName: svgSecureCreds,
    ),
    const OnBoardBox(
      title: title2,
      description: description2,
      svgName: svgQuickAccess,
    ),
    const OnBoardBox(
      title: title2,
      description: description2,
      svgName: svgVault,
    ),
  ];

}