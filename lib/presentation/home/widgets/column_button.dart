import 'package:flutter/material.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';

class ColumnButton extends StatelessWidget {
  final String label;
  final SvgGenImage svgGenImage;
  final VoidCallback onPressed;

  const ColumnButton({
    super.key,
    required this.label,
    required this.svgGenImage,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.primary),
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            ),
            // ignore: deprecated_member_use_from_same_package
            child: svgGenImage.svg(color: AppColors.primary),
          ),
          const SpaceHeight(8.0),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
