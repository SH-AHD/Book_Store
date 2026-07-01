import 'package:bookia/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class AppValidators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.validate_email_empty.tr();
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return LocaleKeys.validate_email_invalid.tr();
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.validate_password_empty.tr();
    }
    if (value.length < 6) {
      return LocaleKeys.validate_password_short.tr();
    }
    return null;
  }

  static String? validatePasswordConfirmation(
    String? value,
    String passwordToMatch,
  ) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.validate_password_empty.tr();
    } else if (value != passwordToMatch) {
      return LocaleKeys.validate_password_mismatch.tr();
    }
    return null;
  }

  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.validate_username_empty.tr();
    }
    if (value.length < 3) {
      return LocaleKeys.validate_username_short.tr();
    }
    return null;
  }

  static String? validateString(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.validate_field_empty.tr();
    }
    if (value.length < 3) {
      return LocaleKeys.validate_field_short.tr();
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.validate_phone_empty.tr();
    } else if (!RegExp(r'^01[0125][0-9]{8}$').hasMatch(value)) {
      return LocaleKeys.validate_phone_invalid.tr();
    }
    return null;
  }
}
