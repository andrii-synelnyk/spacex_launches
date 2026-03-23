import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spacex_launches/launches/data/models/launch.dart';
import 'package:spacex_launches/launches/data/models/rocket.dart';

class LaunchesRepository {
  const LaunchesRepository({required http.Client client}) : _client = client;

  final http.Client _client;

  static const String _baseUrl = 'https://api.spacexdata.com/v3';
  static const String _rocketsPath = '$_baseUrl/rockets';
  static const String _launchesPath = '$_baseUrl/launches';

  Future<List<Rocket>> getRockets() async {
    final response = await _client.get(Uri.parse(_rocketsPath));

    if (response.statusCode != 200) {
      throw Exception('Failed to load rockets');
    }

    final decodedJson = jsonDecode(response.body) as List<dynamic>;

    return decodedJson
        .map(
          (rocketJson) => Rocket.fromJson(rocketJson as Map<String, dynamic>),
        )
        .toList();
  }

  Future<List<Launch>> getLaunchesByRocketId(String rocketId) async {
    final uri = Uri.parse(
      _launchesPath,
    ).replace(queryParameters: <String, String>{'rocket_id': rocketId});

    final response = await _client.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load launches');
    }

    final decodedJson = jsonDecode(response.body) as List<dynamic>;

    return decodedJson
        .map(
          (launchJson) => Launch.fromJson(launchJson as Map<String, dynamic>),
        )
        .toList();
  }
}
