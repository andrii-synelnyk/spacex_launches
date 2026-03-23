import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:spacex_launches/launches/data/launches_repository.dart';
import 'package:spacex_launches/app/app_colors.dart';
import 'package:spacex_launches/launches/presentation/launches_page.dart';

class SpaceXLaunchesApp extends StatelessWidget {
  const SpaceXLaunchesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => LaunchesRepository(client: http.Client()),
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.accentColor),
        ),
        home: const LaunchesPage(),
      ),
    );
  }
}
