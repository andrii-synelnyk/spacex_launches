import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:spacex_launches/launches/data/models/rocket.dart';
import 'package:spacex_launches/app/app_colors.dart';

class RocketCarousel extends StatelessWidget {
  const RocketCarousel({
    required this.rockets,
    required this.selectedIndex,
    required this.onPageChanged,
    super.key,
  });

  final List<Rocket> rockets;
  final int selectedIndex;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: rockets.length,
      itemBuilder: (context, index, realIndex) {
        final rocket = rockets[index];

        return Padding(
          padding: const .symmetric(horizontal: 12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: rocket.imageUrl == null || rocket.imageUrl!.isEmpty
                ? Container(
                    color: AppColors.fill,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.image_not_supported_outlined,
                      color: Colors.white,
                      size: 36,
                    ),
                  )
                : Image.network(
                    rocket.imageUrl!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
          ),
        );
      },
      options: CarouselOptions(
        height: 194,
        viewportFraction: 0.78,
        enlargeFactor: 0.25,
        enlargeCenterPage: true,
        enlargeStrategy: .zoom,
        enableInfiniteScroll: false,
        initialPage: selectedIndex,
        onPageChanged: (index, reason) => onPageChanged(index),
      ),
    );
  }
}
