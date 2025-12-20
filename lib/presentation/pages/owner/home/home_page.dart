import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:qsir_app/presentation/pages/owner/home/widgets/home_background.dart';
import 'package:qsir_app/presentation/pages/owner/home/widgets/home_header.dart';
import 'package:qsir_app/presentation/pages/owner/home/widgets/home_main_menu.dart';
import 'package:qsir_app/presentation/pages/owner/home/widgets/home_shop_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // transparan
        statusBarIconBrightness: Brightness.light, // icon putih
        statusBarBrightness: Brightness.dark, // iOS
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          const HomeBackground(),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 8.h,
                    ),
                    child: Column(
                      children: [
                        const HomeHeader(),
                        SizedBox(height: 16.h),
                        const HomeShopCard(),
                        SizedBox(height: 24.h),
                        const HomeMainMenu(),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
