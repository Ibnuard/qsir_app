import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_diff/models/cash_diff_record.dart';

class CashDiffHistoryCard extends StatelessWidget {
  final CashDiffRecord record;
  final VoidCallback onTap;
  final String Function(double) formatCurrency;
  final String Function(DateTime) formatDate;
  final String Function(DateTime) formatTime;
  final Color Function(double) getStatusColor;
  final String Function(double) getStatusLabel;

  const CashDiffHistoryCard({
    super.key,
    required this.record,
    required this.onTap,
    required this.formatCurrency,
    required this.formatDate,
    required this.formatTime,
    required this.getStatusColor,
    required this.getStatusLabel,
  });

  @override
  Widget build(BuildContext context) {
    final color = getStatusColor(record.amount);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                record.amount == 0
                    ? Icons.check_circle_outline
                    : Icons.warning_amber_rounded,
                color: color,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formatDate(record.openedAt),
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                      fontSize: 10.sp,
                    ),
                  ),
                  Text(
                    "${formatTime(record.openedAt)} - ${formatTime(record.closedAt)}",
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    getStatusLabel(record.amount),
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  formatCurrency(record.amount),
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  formatCurrency(record.saldoFisik),
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: 10.sp,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(width: 8.w),
            Icon(Icons.chevron_right, size: 18.sp, color: Colors.grey.shade300),
          ],
        ),
      ),
    );
  }
}
