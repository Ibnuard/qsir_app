import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/category/list/owner_category_page.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/owner_sub_menu_page.dart';
import 'package:qsir_app/routes/app_routes.dart';

class HomeController extends GetxController {
  final List<Map<String, dynamic>> menuItems = [
    {
      'label': 'Produk & Stock',
      'icon': Icons.inventory_2_rounded,
      'colors': [const Color(0xFF2196F3), const Color(0xFF64B5F6)],
    },
    {
      'label': 'Kas & Shift',
      'icon': Icons.point_of_sale_rounded,
      'colors': [const Color(0xFF4CAF50), const Color(0xFF81C784)],
    },
    {
      'label': 'Managemen Kasir',
      'icon': Icons.badge_rounded,
      'colors': [const Color(0xFFFF9800), const Color(0xFFFFB74D)],
    },
    {
      'label': 'Pelanggan',
      'icon': Icons.groups_rounded,
      'colors': [const Color(0xFF9C27B0), const Color(0xFFBA68C8)],
    },
    {
      'label': 'Sales / Transaksi',
      'icon': Icons.bar_chart_rounded,
      'colors': [const Color(0xFFE91E63), const Color(0xFFF06292)],
    },
    {
      'label': 'Pengaturan',
      'icon': Icons.settings_rounded,
      'colors': [const Color(0xFF607D8B), const Color(0xFF90A4AE)],
    },
  ];

  void navigateToSubMenu(String label) {
    List<SubMenuItem> items = [];
    String title = label;

    switch (label) {
      case 'Produk & Stock':
        items = [
          SubMenuItem(
            title: 'Daftar produk',
            icon: Icons.list_alt,
            onTap: () => navigateToMenu(AppRoutes.ownerProductList),
          ),
          SubMenuItem(
            title: 'Kategori produk',
            icon: Icons.inventory,
            onTap: () => Get.to(() => const OwnerCategoryPage()),
          ),
        ];
        break;
      case 'Kas & Shift':
        items = [
          SubMenuItem(
            title: 'Open / Close shift',
            icon: Icons.swap_horiz,
            onTap: () => navigateToMenu(AppRoutes.ownerCashShift),
          ),
          SubMenuItem(title: 'Riwayat cash in / out', icon: Icons.history),
          SubMenuItem(title: 'Selisih kas', icon: Icons.money_off),
          SubMenuItem(title: 'Laporan penutupan', icon: Icons.summarize),
        ];
        break;
      case 'Managemen Kasir':
        items = [
          SubMenuItem(title: 'Tambah kasir', icon: Icons.person_add),
          SubMenuItem(title: 'Set PIN kasir', icon: Icons.pin),
          SubMenuItem(title: 'Aktif / nonaktif kasir', icon: Icons.toggle_on),
          SubMenuItem(title: 'Riwayat login kasir', icon: Icons.login),
        ];
        break;
      case 'Pelanggan':
        items = [
          SubMenuItem(title: 'Daftar pelanggan', icon: Icons.people),
          SubMenuItem(title: 'Riwayat belanja', icon: Icons.shopping_bag),
          SubMenuItem(title: 'Member / loyalty', icon: Icons.card_membership),
        ];
        break;
      case 'Sales / Transaksi':
        items = [
          SubMenuItem(title: 'Ringkasan penjualan', icon: Icons.analytics),
          SubMenuItem(title: 'Riwayat transaksi', icon: Icons.receipt_long),
          SubMenuItem(title: 'Laporan laba rugi', icon: Icons.payments),
          SubMenuItem(title: 'Produk terlaris', icon: Icons.trending_up),
        ];
        break;
      case 'Pengaturan':
        items = [
          SubMenuItem(title: 'Printer & struk', icon: Icons.print),
          SubMenuItem(title: 'Pajak & biaya', icon: Icons.percent),
          SubMenuItem(title: 'Metode pembayaran', icon: Icons.payment),
          SubMenuItem(title: 'Info outlet', icon: Icons.store),
        ];
        break;
    }

    if (items.isNotEmpty) {
      Get.to(() => OwnerSubMenuPage(title: title, items: items));
    }
  }

  void navigateToMenu(String routes) {
    Get.toNamed(routes);
  }
}
