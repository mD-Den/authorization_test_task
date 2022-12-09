part of 'login_bloc.dart';

class LoginState {
  final String username;
  bool get isValidUsername => username.length < 3;

  final String password;
  bool get isValidPassword => password.length < 6;

  final FormSubmissionStatus formStatus;
  final bool isRegistration;

  LoginState({
    this.username = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
    this.isRegistration = false,
  });

  LoginState copyWith({
    String? username,
    String? password,
    FormSubmissionStatus? formStatus,
    bool? isRegistration,
  }) {
    return LoginState(
        username: username ?? this.username,
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus,
        isRegistration: isRegistration ?? this.isRegistration);
  }
}
