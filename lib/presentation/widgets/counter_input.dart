import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qsir_app/presentation/widgets/custom_input.dart';

class CounterInput extends StatelessWidget {
  final String? label;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final double? minValue;
  final double? maxValue;

  const CounterInput({
    super.key,
    this.label,
    required this.controller,
    this.onChanged,
    this.minValue = 0,
    this.maxValue,
  });

  void _increment() {
    double current = double.tryParse(controller.text) ?? 0;
    if (maxValue == null || current < maxValue!) {
      String newValue = (current + 1).toStringAsFixed(0);
      controller.text = newValue;
      onChanged?.call(newValue);
    }
  }

  void _decrement() {
    double current = double.tryParse(controller.text) ?? 0;
    if (minValue == null || current > minValue!) {
      String newValue = (current - 1).toStringAsFixed(0);
      controller.text = newValue;
      onChanged?.call(newValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
        ],
        Row(
          children: [
            _buildButton(icon: Icons.remove, onPressed: _decrement),
            SizedBox(width: 12.w),
            Expanded(
              child: CustomInput(
                controller: controller,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: onChanged,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 16.w,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            _buildButton(icon: Icons.add, onPressed: _increment),
          ],
        ),
      ],
    );
  }

  Widget _buildButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          width: 48.w,
          height: 48.w,
          alignment: Alignment.center,
          child: Icon(icon, size: 20.sp, color: Colors.black87),
        ),
      ),
    );
  }
}
