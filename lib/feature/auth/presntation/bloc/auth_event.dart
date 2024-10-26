import 'package:se7ety/core/enum/user_type.dart';

class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String passWord;
  final UserType userType;

  LoginEvent({
    required this.email,
    required this.userType,
    required this.passWord,
  });
}

class RegisterEvent extends AuthEvent {
  final String name;
  final String email;
  final String passWord;
  final UserType userType;

  RegisterEvent({
    required this.name,
    required this.email,
    required this.passWord,
    required this.userType,
  });
}
