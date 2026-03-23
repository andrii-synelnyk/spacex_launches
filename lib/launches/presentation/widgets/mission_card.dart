import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spacex_launches/launches/data/models/launch.dart';
import 'package:spacex_launches/app/app_colors.dart';

class MissionCard extends StatelessWidget {
  const MissionCard({required this.launch, required this.onTap, super.key});

  final Launch launch;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dateText = DateFormat('dd/MM/yyyy').format(launch.launchDateUtc);
    final timeText = DateFormat('h:mm a').format(launch.launchDateUtc);

    return GestureDetector(
      onTap: launch.wikipediaUrl == null || launch.wikipediaUrl!.isEmpty
          ? null
          : onTap,
      child: Container(
        padding: const .all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.fill,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dateText,
                  style: const TextStyle(
                    color: AppColors.accentColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  timeText,
                  style: const TextStyle(
                    color: AppColors.caption,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    launch.missionName,
                    style: const TextStyle(
                      color: AppColors.title,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    launch.launchSiteNameLong,
                    style: const TextStyle(
                      color: AppColors.caption,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
