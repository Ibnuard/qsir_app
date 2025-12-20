import 'package:flutter/material.dart';
import 'package:qsir_app/core/themes/app_theme.dart';

class HomeBackground extends StatelessWidget {
  const HomeBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.20,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.primary.withValues(alpha: 0.8),
            const Color(0xFFFF8C42),
          ],
          stops: const [0.1, 0.6, 1.0],
        ),
      ),
    );
  }
}
