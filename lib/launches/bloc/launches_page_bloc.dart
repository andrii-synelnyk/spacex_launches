import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_launches/launches/bloc/launches_page_event.dart';
import 'package:spacex_launches/launches/bloc/launches_page_state.dart';
import 'package:spacex_launches/launches/data/launches_repository.dart';

class LaunchesPageBloc extends Bloc<LaunchesPageEvent, LaunchesPageState> {
  LaunchesPageBloc({required LaunchesRepository launchesRepository})
    : _launchesRepository = launchesRepository,
      super(const LaunchesPageState()) {
    on<LaunchesPageStarted>(_onStarted);
    on<RocketSelected>(_onRocketSelected);
  }

  final LaunchesRepository _launchesRepository;

  Future<void> _onStarted(
    LaunchesPageStarted event,
    Emitter<LaunchesPageState> emit,
  ) async {
    emit(
      state.copyWith(
        rocketsStatus: ViewStatus.loading,
        launchesStatus: ViewStatus.initial,
        errorMessage: null,
      ),
    );

    try {
      final rockets = await _launchesRepository.getRockets();
      final firstRocket = rockets.first;

      emit(
        state.copyWith(
          rocketsStatus: ViewStatus.success,
          rockets: rockets,
          selectedRocketIndex: 0,
          selectedRocketId: firstRocket.id,
          launchesStatus: ViewStatus.loading,
          currentLaunches: const [],
          errorMessage: null,
        ),
      );

      final launches = await _launchesRepository.getLaunchesByRocketId(
        firstRocket.id,
      );

      emit(
        state.copyWith(
          launchesStatus: ViewStatus.success,
          currentLaunches: launches,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          rocketsStatus: ViewStatus.failure,
          launchesStatus: ViewStatus.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> _onRocketSelected(
    RocketSelected event,
    Emitter<LaunchesPageState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedRocketIndex: event.index,
        selectedRocketId: event.rocketId,
        launchesStatus: ViewStatus.loading,
        currentLaunches: const [],
        errorMessage: null,
      ),
    );

    try {
      final launches = await _launchesRepository.getLaunchesByRocketId(
        event.rocketId,
      );

      emit(
        state.copyWith(
          launchesStatus: ViewStatus.success,
          currentLaunches: launches,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          launchesStatus: ViewStatus.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
