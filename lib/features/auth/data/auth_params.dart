class AuthParams {
  final String? name;
  final String? email;
  final String? password;
  final String? passwordConfirmation;
  final String? verifyCode;
  final String? newPassword;
  final String? newPasswordConfirmation;

  AuthParams({
    this.name,
    this.email,
    this.password,
    this.passwordConfirmation,
    this.verifyCode,
    this.newPassword,
    this.newPasswordConfirmation,
  });

  factory AuthParams.register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) => AuthParams(
    name: name,
    email: email,
    password: password,
    passwordConfirmation: passwordConfirmation,
  );

  factory AuthParams.login({required String email, required String password}) =>
      AuthParams(email: email, password: password);

  factory AuthParams.verify({String? email, required String code}) =>
      AuthParams(email: email, verifyCode: code);

  factory AuthParams.resetPassword({
    required String code,
    required String newPassword,
    required String newPasswordConfirmation,
  }) => AuthParams(
    verifyCode: code,
    newPassword: newPassword,
    newPasswordConfirmation: newPasswordConfirmation,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (name != null) map["name"] = name;
    if (email != null) map["email"] = email;
    if (password != null) map["password"] = password;
    if (passwordConfirmation != null) {
      map["password_confirmation"] = passwordConfirmation;
    }
    if (verifyCode != null) map["verify_code"] = verifyCode;
    if (newPassword != null) map["new_password"] = newPassword;
    if (newPasswordConfirmation != null) {
      map["new_password_confirmation"] = newPasswordConfirmation;
    }

    return map;
  }
}
