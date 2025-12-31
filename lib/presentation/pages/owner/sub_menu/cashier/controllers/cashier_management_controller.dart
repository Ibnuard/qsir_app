import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cashier/models/cashier.dart';

class CashierManagementController extends GetxController {
  final cashiers = <Cashier>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadCashiers();
  }

  void _loadCashiers() {
    isLoading.value = true;
    // Mock data for initial implementation
    cashiers.value = [
      Cashier(
        id: '1',
        name: 'Ahmad Faisal',
        joinedAt: DateTime.now().subtract(const Duration(days: 30)),
        isActive: true,
      ),
      Cashier(
        id: '2',
        name: 'Siti Aminah',
        joinedAt: DateTime.now().subtract(const Duration(days: 15)),
        isActive: true,
      ),
      Cashier(
        id: '3',
        name: 'Budi Santoso',
        joinedAt: DateTime.now().subtract(const Duration(days: 5)),
        isActive: false,
      ),
    ];
    isLoading.value = false;
  }

  void toggleCashierStatus(String id) {
    final index = cashiers.indexWhere((c) => c.id == id);
    if (index != -1) {
      final updatedCashier = cashiers[index].copyWith(
        isActive: !cashiers[index].isActive,
      );
      cashiers[index] = updatedCashier;

      // Show feedback
      Get.snackbar(
        'Status Diperbarui',
        'Kasir ${updatedCashier.name} kini ${updatedCashier.isActive ? 'Aktif' : 'Non-aktif'}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void addCashier(String name, String password) {
    // In a real application, the password would be hashed before storage.
    final newCashier = Cashier(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      joinedAt: DateTime.now(),
      isActive: true,
    );
    cashiers.insert(0, newCashier);

    Get.back(); // Close bottom sheet
    Get.snackbar(
      'Berhasil',
      'Kasir $name telah ditambahkan',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withValues(alpha: 0.1),
      colorText: Colors.green.shade700,
    );
  }

  String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy', 'id_ID').format(date);
  }
}
