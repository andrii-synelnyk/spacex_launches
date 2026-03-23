class Launch {
  const Launch({
    required this.missionName,
    required this.launchDateUtc,
    required this.launchSiteName,
    required this.launchSiteNameLong,
    required this.wikipediaUrl,
  });

  factory Launch.fromJson(Map<String, dynamic> json) {
    final launchSiteJson = json['launch_site'] as Map<String, dynamic>?;
    final linksJson = json['links'] as Map<String, dynamic>?;

    return Launch(
      missionName: json['mission_name'] as String? ?? 'Unknown mission',
      launchDateUtc: DateTime.parse(json['launch_date_utc'] as String),
      launchSiteName:
          launchSiteJson?['site_name'] as String? ?? 'Unknown launch site',
      launchSiteNameLong:
          launchSiteJson?['site_name_long'] as String? ?? 'Unknown launch site',
      wikipediaUrl: linksJson?['wikipedia'] as String?,
    );
  }

  final String missionName;
  final DateTime launchDateUtc;
  final String launchSiteName;
  final String launchSiteNameLong;
  final String? wikipediaUrl;
}
