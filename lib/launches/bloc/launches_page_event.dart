import 'package:equatable/equatable.dart';

sealed class LaunchesPageEvent extends Equatable {
  const LaunchesPageEvent();

  @override
  List<Object?> get props => [];
}

final class LaunchesPageStarted extends LaunchesPageEvent {
  const LaunchesPageStarted();
}

final class RocketSelected extends LaunchesPageEvent {
  const RocketSelected({required this.rocketId, required this.index});

  final String rocketId;
  final int index;

  @override
  List<Object?> get props => [rocketId, index];
}
