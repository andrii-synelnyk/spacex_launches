import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_launches/launches/bloc/launches_page_bloc.dart';
import 'package:spacex_launches/launches/bloc/launches_page_event.dart';
import 'package:spacex_launches/launches/bloc/launches_page_state.dart';
import 'package:spacex_launches/app/app_colors.dart';
import 'package:spacex_launches/launches/presentation/widgets/mission_card.dart';
import 'package:spacex_launches/launches/presentation/widgets/rocket_carousel.dart';
import 'package:spacex_launches/launches/presentation/widgets/slider_indicator_row.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchesView extends StatelessWidget {
  const LaunchesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<LaunchesPageBloc, LaunchesPageState>(
          builder: (context, state) {
            if (state.rocketsStatus == ViewStatus.loading &&
                state.rockets.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.rocketsStatus == ViewStatus.failure) {
              return Center(
                child: Text(state.errorMessage ?? 'Something went wrong.'),
              );
            }

            return Column(
              children: [
                const SizedBox(height: 24),
                const Text(
                  'SpaceX Launches',
                  style: TextStyle(
                    color: AppColors.title,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),
                RocketCarousel(
                  rockets: state.rockets,
                  selectedIndex: state.selectedRocketIndex,
                  onPageChanged: (index) {
                    final rocket = state.rockets[index];
                    context.read<LaunchesPageBloc>().add(
                      RocketSelected(rocketId: rocket.id, index: index),
                    );
                  },
                ),
                const SizedBox(height: 12),
                SliderIndicatorRow(
                  itemCount: state.rockets.length,
                  selectedIndex: state.selectedRocketIndex,
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: Padding(
                    padding: const .symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        const Text(
                          'Missions',
                          style: TextStyle(
                            color: AppColors.title,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Expanded(
                          child: _LaunchesSection(
                            state: state,
                            onLaunchTap: (url) async {
                              if (url == null || url.isEmpty) {
                                return;
                              }

                              final uri = Uri.parse(url);
                              await launchUrl(uri);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _LaunchesSection extends StatelessWidget {
  const _LaunchesSection({required this.state, required this.onLaunchTap});

  final LaunchesPageState state;
  final Future<void> Function(String? url) onLaunchTap;

  @override
  Widget build(BuildContext context) {
    if (state.launchesStatus == ViewStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.launchesStatus == ViewStatus.failure) {
      return Center(
        child: Text(state.errorMessage ?? 'Failed to load launches.'),
      );
    }

    if (state.currentLaunches.isEmpty) {
      return const Center(
        child: Text(
          'No launches found.',
          style: TextStyle(color: AppColors.caption),
        ),
      );
    }

    return ListView.separated(
      itemCount: state.currentLaunches.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final launch = state.currentLaunches[index];

        return MissionCard(
          launch: launch,
          onTap: () => onLaunchTap(launch.wikipediaUrl),
        );
      },
    );
  }
}
