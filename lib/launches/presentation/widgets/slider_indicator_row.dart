import 'package:flutter/material.dart';
import 'package:spacex_launches/app/app_colors.dart';

class SliderIndicatorRow extends StatelessWidget {
  const SliderIndicatorRow({
    required this.itemCount,
    required this.selectedIndex,
    super.key,
  });

  final int itemCount;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        final isActive = selectedIndex == index;
        return Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? Colors.white : AppColors.background,
            border: Border.all(color: Colors.white),
          ),
        );
      }),
    );
  }
}
