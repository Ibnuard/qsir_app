import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qsir_app/presentation/pages/owner/home/home_page.dart';
import 'package:qsir_app/presentation/pages/owner/main/controllers/owner_main_controller.dart';
import 'package:qsir_app/presentation/pages/owner/profile/profile_page.dart';
import 'package:qsir_app/presentation/pages/owner/statistics/statistics_page.dart';

class OwnerMainPage extends GetView<OwnerMainController> {
  const OwnerMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = const [
      HomePage(),
      StatisticsPage(),
      ProfilePage(),
    ];

    return Scaffold(
      body: Obx(() => pages[controller.currentIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changePage,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                controller.currentIndex.value == 0
                    ? Icons.home
                    : Icons.home_outlined,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                controller.currentIndex.value == 1
                    ? Icons.bar_chart
                    : Icons.bar_chart_outlined,
              ),
              label: 'Laporan',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                controller.currentIndex.value == 2
                    ? Icons.store
                    : Icons.store_outlined,
              ),
              label: 'Toko',
            ),
          ],
        ),
      ),
    );
  }
}
