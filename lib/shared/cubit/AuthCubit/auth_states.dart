class AuthStates{}
class changePasswordVisibility extends AuthStates{}
class InitialAppState extends AuthStates{}
class createSuccessState extends AuthStates{}
class createErrorState extends AuthStates{}
class LoginLoadingState extends AuthStates{}
class LoginSuccessState extends AuthStates{
}
class LoginErrorState extends AuthStates{
  final String error;
  LoginErrorState(this.error);
}
class RegisterLoadingState extends AuthStates{}
class RegisterSuccessState extends AuthStates{}
class AdminLoadingState extends AuthStates{}
class emailVerificationState extends AuthStates{}
class AdminSuccessState extends AuthStates{}
class RegisterErrorState extends AuthStates{
  final String error;
  RegisterErrorState(this.error);
}