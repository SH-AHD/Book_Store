class AppValidators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

static String? validatePasswordConfirmation(String? value, String passwordToMatch) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  } else if (value != passwordToMatch) {
    return 'Must be matched with password';
  }
  return null;
}
// static String? Function(String?) validateConfirmPassword(String passwordToMatch) {
//   return (String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter your password';
//     } else if (value != passwordToMatch) {
//       return 'Must be matched with password';
//     }
//     return null;
//   };
// }
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your User name';
    }
    if (value.length < 3) {
      return 'User name must be at least 3 characters';
    }
    return null;
  }

}