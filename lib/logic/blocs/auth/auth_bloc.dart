import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/app_data.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<SendOtpEvent>(_onSendOtp);
    on<VerifyOtpEvent>(_onVerifyOtp);
    on<RegisterUserEvent>(_onRegisterUser);
  }

  void _onSendOtp(SendOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));
    
    final phoneVal = event.phoneNumber.replaceAll(RegExp(r'\D'), '');
    if (phoneVal.length != 10) {
      emit(const AuthFailureState('Please enter a valid 10-digit mobile number'));
      return;
    }
    emit(OtpSentState(phoneVal));
  }

  void _onVerifyOtp(VerifyOtpEvent event, Emitter<AuthState> emit) async {
    final currentState = state;
    if (currentState is OtpSentState) {
      final phone = currentState.phoneNumber;
      emit(AuthLoadingState());
      
      // Simulate verification loading delay
      await Future.delayed(const Duration(seconds: 1));
      
      if (event.otpCode.length == 4) {
        final isRegistered = AppData.registeredPhones.contains(phone);
        emit(AuthOtpVerifiedState(isRegistered: isRegistered, phoneNumber: phone));
      } else {
        emit(const AuthFailureState('Incorrect OTP code. Please try again.'));
      }
    }
  }

  void _onRegisterUser(RegisterUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    // Simulate registration delay
    await Future.delayed(const Duration(milliseconds: 800));
    
    AppData.registeredPhones.add(event.phoneNumber);
    emit(AuthSuccessState());
  }
}
