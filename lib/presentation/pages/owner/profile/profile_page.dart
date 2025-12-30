import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qsir_app/core/themes/app_theme.dart';
import 'package:qsir_app/routes/app_routes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          "Profil & Toko",
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(context),
            SizedBox(height: 12.h),
            _buildMenuSection(context),
            SizedBox(height: 24.h),
            _buildLogoutButton(context),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50.r,
            backgroundColor: AppColors.primary.withValues(alpha: 0.1),
            child: Icon(Icons.store, size: 50.sp, color: AppColors.primary),
          ),
          SizedBox(height: 16.h),
          Text(
            "Kopi Kenangan Mantan",
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "Jl. Sudirman No. 123, Jakarta Pusat",
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            "0812-3456-7890",
            style: context.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _buildMenuItem(
            context,
            icon: Icons.edit_note_rounded,
            title: "Informasi Toko",
            subtitle: "Ubah nama, alamat, dan logo toko",
            onTap: () {},
          ),
          _buildDivider(),
          _buildMenuItem(
            context,
            icon: Icons.person_outline_rounded,
            title: "Akun Pemilik",
            subtitle: "Update email, password, dan PIN",
            onTap: () {},
          ),
          _buildDivider(),
          _buildMenuItem(
            context,
            icon: Icons.help_outline_rounded,
            title: "Pusat Bantuan",
            subtitle: "Hubungi tim support Qsir",
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      leading: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(icon, color: Colors.blueGrey, size: 24.sp),
      ),
      title: Text(
        title,
        style: context.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: context.textTheme.bodySmall?.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
      trailing: Icon(Icons.chevron_right, color: Colors.grey, size: 20.sp),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, indent: 70.w, color: Colors.grey.shade100);
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: SizedBox(
        width: double.infinity,
        height: 52.h,
        child: OutlinedButton.icon(
          onPressed: () {
            Get.defaultDialog(
              title: "Logout",
              middleText: "Apakah Anda yakin ingin keluar?",
              textCancel: "Batal",
              textConfirm: "Ya, Keluar",
              confirmTextColor: Colors.white,
              buttonColor: AppColors.error,
              onConfirm: () {
                Get.offAllNamed(AppRoutes.login);
              },
            );
          },
          icon: Icon(Icons.logout_rounded, color: AppColors.error, size: 20.sp),
          label: Text(
            "Ganti Akun",
            style: TextStyle(
              color: AppColors.error,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.error),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
      ),
    );
  }
}
