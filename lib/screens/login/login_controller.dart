import 'dart:math';
import 'package:credsafe/screens/dashboard/dashboard_screen.dart';
import 'package:credsafe/utils/common_widgets/navigator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var mobileNumber = ''.obs;
  var generatedOtp = ''.obs;
  var isOtpFieldVisible = false.obs;

  final mobileController = TextEditingController();
  final otpController = TextEditingController();
  final mobileFocusNode = FocusNode();
  final otpFocusNode = FocusNode();



  void validateAndSendOtp() {
    String mobile = mobileController.text.trim();
    if (mobile.isEmpty) {
      Get.snackbar("Error", "Mobile number cannot be empty");
    } else if (!RegExp(r'^\d{10}$').hasMatch(mobile)) {
      Get.snackbar("Error", "Enter a valid 10-digit mobile number");
    } else {
      // Generate a 6-digit OTP locally
      generatedOtp.value = generateOtp();
      mobileNumber.value = mobile;
      isOtpFieldVisible.value = true;

      Get.snackbar("Success", "OTP has been sent: ${generatedOtp.value}");
    }
  }

  String generateOtp() {
    final random = Random();
    return (100000 + random.nextInt(900000)).toString();
  }

  void login() {
    String enteredOtp = otpController.text.trim();
    if (enteredOtp.isEmpty) {
      Get.snackbar("Error", "OTP cannot be empty");
    } else if (enteredOtp == generatedOtp.value) {
      Get.snackbar("Success", "Login successful!");
    } else {
      Get.snackbar("Error", "Invalid OTP");
    }
  }
  void validateField() {
    isOtpFieldVisible.value = true;
    otpController.text = generateOtp();
  }

  void navigateToScreen(BuildContext screenContext) {
      if(otpController.text.isNotEmpty) {
        AppNavigator.commonNavigator(screenContext, Dashboard());
        clearField();
      }
  }

  clearField() {
    mobileController.clear();
    otpController.clear();
  }

  @override
  void dispose() {
    mobileController.dispose();
    mobileFocusNode.dispose();
    otpController.dispose();
    otpFocusNode.dispose();
    super.dispose();
  }
}
