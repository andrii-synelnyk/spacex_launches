import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_launches/launches/bloc/launches_page_bloc.dart';
import 'package:spacex_launches/launches/bloc/launches_page_event.dart';
import 'package:spacex_launches/launches/data/launches_repository.dart';
import 'package:spacex_launches/launches/presentation/launches_view.dart';

class LaunchesPage extends StatelessWidget {
  const LaunchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LaunchesPageBloc(
        launchesRepository: context.read<LaunchesRepository>(),
      )..add(const LaunchesPageStarted()),
      child: const LaunchesView(),
    );
  }
}
