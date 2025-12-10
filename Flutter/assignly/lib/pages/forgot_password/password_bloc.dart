import 'package:assignly/pages/forgot_password/password_events_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordState {
  const PasswordState();

  PasswordState copyWith() => const PasswordState();
}

class UpdatePasswordState extends PasswordState { const UpdatePasswordState(); }
class ShowPasswordState extends PasswordState { const ShowPasswordState(); }

class PasswordBloc extends Bloc<PasswordEvents, PasswordState> {
  PasswordBloc() : super(const PasswordState()) { on<PasswordEvents>(_onEvent); }

  void _onEvent(PasswordEvents event, Emitter<PasswordState> emit) {
    if (event is UpdatePasswordPage) {
      emit(const UpdatePasswordState());
      emit(const ShowPasswordState());
    }
  }
}
