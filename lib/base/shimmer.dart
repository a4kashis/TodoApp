import 'package:flutter/material.dart';
import 'package:todo/app/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final double borderRadius;

  const ShimmerContainer({
    Key? key,
    this.height = 20.0,
    this.width = double.infinity,
    this.borderRadius = 4.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor,
      highlightColor: AppColors.shimmerHighlightColor,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(borderRadius)),
      ),
    );
  }
}
