import 'package:assignly/pages/planning_page/planning_events_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanningState {
  const PlanningState();

  PlanningState copyWith() => const PlanningState();
}

class UpdatePlanningState extends PlanningState { const UpdatePlanningState(); }
class ShowPlanningState extends PlanningState { const ShowPlanningState(); }

class PlanningBloc extends Bloc<PlanningEvents, PlanningState> {
  PlanningBloc() : super(const PlanningState()) { on<PlanningEvents>(_onEvent); }

  void _onEvent(PlanningEvents event, Emitter<PlanningState> emit) {
    if (event is UpdatePlanningPage) {
      emit(const UpdatePlanningState());
      emit(const ShowPlanningState());
    }
  }
}
