class AuthState {}

class AuthInitial extends AuthState {}

//Login

class LoginLoadingState extends AuthState {}

class LoginSuccesState extends AuthState {}

//Register

class RegisterLoadingState extends AuthState {}

class RegisterSuccesState extends AuthState {}

//Update Docotor Regestration

class UpdateDoctorLoadingState extends AuthState {}

class UpdateDoctorSuccessState extends AuthState {}

//Error

class AuthErrorState extends AuthState {
  final String error;
  AuthErrorState( {required this.error});
}
