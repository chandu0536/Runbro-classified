abstract class AuthState {
  const AuthState();
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class OtpSentState extends AuthState {
  final String phoneNumber;
  const OtpSentState(this.phoneNumber);
}

class AuthOtpVerifiedState extends AuthState {
  final bool isRegistered;
  final String phoneNumber;
  const AuthOtpVerifiedState({required this.isRegistered, required this.phoneNumber});
}

class AuthSuccessState extends AuthState {}

class AuthFailureState extends AuthState {
  final String error;
  const AuthFailureState(this.error);
}
