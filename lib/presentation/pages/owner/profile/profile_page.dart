import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qsir_app/presentation/pages/owner/profile/widgets/logout_button.dart';
import 'package:qsir_app/presentation/pages/owner/profile/widgets/profile_header.dart';
import 'package:qsir_app/presentation/pages/owner/profile/widgets/profile_menu_item.dart';

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
            const ProfileHeader(
              storeName: "Kopi Kenangan Mantan",
              storeAddress: "Jl. Sudirman No. 123, Jakarta Pusat",
              storePhone: "0812-3456-7890",
            ),
            SizedBox(height: 12.h),
            _buildMenuSection(context),
            SizedBox(height: 24.h),
            const LogoutButton(),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          ProfileMenuItem(
            icon: Icons.edit_note_rounded,
            title: "Informasi Toko",
            subtitle: "Ubah nama, alamat, dan logo toko",
            onTap: () {},
          ),
          _buildDivider(),
          ProfileMenuItem(
            icon: Icons.person_outline_rounded,
            title: "Akun Pemilik",
            subtitle: "Update email, password, dan PIN",
            onTap: () {},
          ),
          _buildDivider(),
          ProfileMenuItem(
            icon: Icons.help_outline_rounded,
            title: "Pusat Bantuan",
            subtitle: "Hubungi tim support Qsir",
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, indent: 70.w, color: Colors.grey.shade100);
  }
}
