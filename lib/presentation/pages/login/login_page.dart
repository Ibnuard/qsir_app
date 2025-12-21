import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qsir_app/core/values/images_assets.dart';
import 'package:qsir_app/presentation/widgets/input_group.dart';
import 'package:qsir_app/routes/app_routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final InputGroupController _inputGroupController = InputGroupController();

  @override
  void dispose() {
    _inputGroupController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: .center,
                crossAxisAlignment: .start,
                children: [
                  Center(
                    child: Image(
                      image: Images.LOGO,
                      width: 215.w,
                      height: 92.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Text("Masuk", style: context.textTheme.titleLarge),
                  Text(
                    "Silahkan masuk untuk melanjutkan",
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  InputGroup(
                    controller: _inputGroupController,
                    items: [
                      InputGroupItem(
                        key: 'user_id',
                        label: "User ID",
                        decoration: InputDecoration(
                          hintText: "Masukan User ID",
                          hintStyle: context.textTheme.bodyLarge?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      InputGroupItem(
                        key: 'password',
                        label: "Password",
                        decoration: InputDecoration(
                          hintText: "Masukan Password",
                          hintStyle: context.textTheme.bodyLarge?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        isPassword: true,
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        print(
                          "User ID: ${_inputGroupController.getText('user_id')}",
                        );
                        print(
                          "Password: ${_inputGroupController.getText('password')}",
                        );

                        Get.offNamed(AppRoutes.ownerMain);
                      },
                      child: Text("Masuk"),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 24.h),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Versi 'Still on Development'",
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
