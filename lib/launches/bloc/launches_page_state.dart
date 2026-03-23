import 'package:equatable/equatable.dart';
import 'package:spacex_launches/launches/data/models/launch.dart';
import 'package:spacex_launches/launches/data/models/rocket.dart';

enum ViewStatus { initial, loading, success, failure }

class LaunchesPageState extends Equatable {
  const LaunchesPageState({
    this.rocketsStatus = ViewStatus.initial,
    this.launchesStatus = ViewStatus.initial,
    this.rockets = const [],
    this.currentLaunches = const [],
    this.selectedRocketIndex = 0,
    this.selectedRocketId,
    this.errorMessage,
  });

  final ViewStatus rocketsStatus;
  final ViewStatus launchesStatus;
  final List<Rocket> rockets;
  final List<Launch> currentLaunches;
  final int selectedRocketIndex;
  final String? selectedRocketId;
  final String? errorMessage;

  LaunchesPageState copyWith({
    ViewStatus? rocketsStatus,
    ViewStatus? launchesStatus,
    List<Rocket>? rockets,
    List<Launch>? currentLaunches,
    int? selectedRocketIndex,
    String? selectedRocketId,
    String? errorMessage,
  }) {
    return LaunchesPageState(
      rocketsStatus: rocketsStatus ?? this.rocketsStatus,
      launchesStatus: launchesStatus ?? this.launchesStatus,
      rockets: rockets ?? this.rockets,
      currentLaunches: currentLaunches ?? this.currentLaunches,
      selectedRocketIndex: selectedRocketIndex ?? this.selectedRocketIndex,
      selectedRocketId: selectedRocketId ?? this.selectedRocketId,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    rocketsStatus,
    launchesStatus,
    rockets,
    currentLaunches,
    selectedRocketIndex,
    selectedRocketId,
    errorMessage,
  ];
}
