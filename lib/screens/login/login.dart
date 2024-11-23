import 'package:credsafe/screens/login/login_controller.dart';
import 'package:credsafe/utils/common_widgets/button.dart';
import 'package:credsafe/utils/common_widgets/common_text.dart';
import 'package:credsafe/utils/constants/app_color.dart';
import 'package:credsafe/utils/constants/app_constants.dart';
import 'package:credsafe/utils/constants/app_decoration.dart';
import 'package:credsafe/utils/constants/image_constant.dart';
import 'package:credsafe/utils/sizes/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:credsafe/domain/mixins/form_validation.dart';
import 'package:pinput/pinput.dart';



class Login extends StatelessWidget with InputValidationMixin {
  Login({super.key});

  final loginController = Get.put(LoginController());
  final loginFormGlobalKey = GlobalKey<FormState>();
  var code = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: CommonText(text: login,textStyle: AppStyle.txtBlack20,),
          backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(p16),
        child: SingleChildScrollView(
          child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: h200,
                  width: w200,
                  child: SvgPicture.asset(svgQuickAccess),
                ),
              ),
              const SizedBox(height: h32),
              Form(
                key: loginFormGlobalKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: loginController.mobileController,
                      keyboardType: TextInputType.phone,
                      decoration:  InputDecoration(
                        labelText: mobileNumber,
                        hintText: enterMobile,
                        labelStyle: AppStyle.txtBlack16,
                        hintStyle: AppStyle.txtGrey16,
                        border: const OutlineInputBorder(),
                      ),
                      focusNode: loginController.mobileFocusNode,
                      maxLength: 10,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        String str = value!;
                        if (value.isEmpty) {
                          return emptyErrorLbl;
                        } else if (str.startsWith('0') ||
                            str.startsWith('1') ||
                            str.startsWith('2') ||
                            str.startsWith('3') ||
                            str.startsWith('4') ||
                            str.startsWith('5')) {
                          return startWithNumberLbl;
                        } else if (value.length < 10) {
                          return mobileNumberDigitError2Lbl;
                        } else {
                          isMobileNumberValid(value);
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: h16),
                    if (loginController.isOtpFieldVisible.value)
                      Pinput(
                        length: 6,
                        showCursor: true,
                        controller: loginController.otpController,
                        focusNode: loginController.otpFocusNode,
                        //autofocus: true,
                        keyboardType: TextInputType.number,
                        validator: (otpValue) {
                          if (otpValue!.isEmpty) {
                            return emptyErrorLbl;
                          } else if (otpValue.length < 6) {
                            return otpDigitErrorLbl;
                          } else {
                            isValidateOtp(otpValue);
                          }
                          return null;
                        },
                        onChanged: (value) {
                          code = value;
                        },
                      ),
                    const SizedBox(height: h16),
                    SizedBox(
                      width: double.infinity,
                      child: AppButton(
                        btnLabel: loginController.isOtpFieldVisible.value ? login : getOTP,
                        firstColor: AppColor.hexBlue,
                        secondColor: AppColor.hexBlue,
                        onTap: () {
                          if (loginController.isOtpFieldVisible.value) {
                            loginController.navigateToScreen(context);
                          } else {
                            if (loginFormGlobalKey.currentState!.validate()) {
                              loginFormGlobalKey.currentState!.save();
                              loginController.validateField();
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}