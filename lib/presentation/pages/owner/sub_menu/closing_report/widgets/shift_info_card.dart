import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_diff/models/cash_diff_record.dart';

class ShiftInfoCard extends StatelessWidget {
  final CashDiffRecord record;
  final String Function(DateTime) formatDate;
  final String Function(DateTime) formatTime;

  const ShiftInfoCard({
    super.key,
    required this.record,
    required this.formatDate,
    required this.formatTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: [
          _buildInfoRow(context, Icons.tag, "Shift ID", record.id),
          SizedBox(height: 12.h),
          _buildInfoRow(
            context,
            Icons.calendar_today_outlined,
            "Tanggal",
            formatDate(record.openedAt),
          ),
          SizedBox(height: 12.h),
          _buildInfoRow(
            context,
            Icons.person_outline,
            "Dibuka oleh",
            record.openedBy,
          ),
          SizedBox(height: 12.h),
          _buildInfoRow(
            context,
            Icons.access_time,
            "Waktu buka",
            formatTime(record.openedAt),
          ),
          SizedBox(height: 12.h),
          _buildInfoRow(context, Icons.person, "Ditutup oleh", record.closedBy),
          SizedBox(height: 12.h),
          _buildInfoRow(
            context,
            Icons.access_time_filled,
            "Waktu tutup",
            formatTime(record.closedAt),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      children: [
        Icon(icon, size: 14.sp, color: Colors.grey),
        SizedBox(width: 10.w),
        Text(
          label,
          style: context.textTheme.bodySmall?.copyWith(color: Colors.grey),
        ),
        const Spacer(),
        Text(
          value,
          style: context.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
