part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginUsernameChangedEvent extends LoginEvent {
  final String username;

  LoginUsernameChangedEvent({required this.username});
}

class LoginPasswordChangedEvent extends LoginEvent {
  final String password;

  LoginPasswordChangedEvent({required this.password});
}

class LoginCheckEvent extends LoginEvent {
  final BuildContext context;

  LoginCheckEvent(this.context);
}

class LoginRegistrationEvent extends LoginEvent {
  final BuildContext context;

  LoginRegistrationEvent(this.context);
}

class LoginSwitchingToRegistrationEvent extends LoginEvent {
  final bool isRegistration;

  LoginSwitchingToRegistrationEvent(this.isRegistration);
}
