import 'package:assignly/pages/login/login_events_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginState {
  const LoginState();

  LoginState copyWith() => const LoginState();
}

class UpdateLoginState extends LoginState { const UpdateLoginState(); }
class ShowLoginState extends LoginState { const ShowLoginState(); }

class LoginBloc extends Bloc<LoginEvents, LoginState> {
  LoginBloc() : super(const LoginState()) { on<LoginEvents>(_onEvent); }

  void _onEvent(LoginEvents event, Emitter<LoginState> emit) {
    if (event is UpdateLoginPage) {
      emit(const UpdateLoginState());
      emit(const ShowLoginState());
    }
  }
}
