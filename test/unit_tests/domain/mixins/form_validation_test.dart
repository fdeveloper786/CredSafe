
import 'package:credsafe/domain/mixins/form_validation.dart';
import 'package:flutter_test/flutter_test.dart';

class InputValidator with InputValidationMixin {}

void main() {
  late InputValidator inputValidator;

  setUp(() {
    inputValidator = InputValidator();
  });


  group('InputValidationMixin Tests', () {

    test('isMobileNumberValid returns true for valid mobile numbers', () {
      expect(inputValidator.isMobileNumberValid('abcd1234'),false);
      expect(inputValidator.isMobileNumberValid(''),false);
      expect(inputValidator.isMobileNumberValid('@#%&*!'),false);
    });

    test('isValidateOtp returns true for valid OTPs', () {
      expect(inputValidator.isValidateOtp('1234'), true);
      expect(inputValidator.isValidateOtp('0000'),true);
      expect(inputValidator.isValidateOtp('98765'),true);
    });

    test('isValidateOtp returns false for valid OTPs', () {
      expect(inputValidator.isValidateOtp('abcd'), false);
      expect(inputValidator.isValidateOtp(''),false);
      expect(inputValidator.isValidateOtp('@#%&*!'),false);
    });
  });
}

