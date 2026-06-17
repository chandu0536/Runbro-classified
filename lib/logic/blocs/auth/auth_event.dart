abstract class AuthEvent {
  const AuthEvent();
}

class SendOtpEvent extends AuthEvent {
  final String phoneNumber;
  const SendOtpEvent(this.phoneNumber);
}

class VerifyOtpEvent extends AuthEvent {
  final String otpCode;
  const VerifyOtpEvent(this.otpCode);
}

class RegisterUserEvent extends AuthEvent {
  final String name;
  final String email;
  final String phoneNumber;
  const RegisterUserEvent({
    required this.name,
    required this.email,
    required this.phoneNumber,
  });
}
