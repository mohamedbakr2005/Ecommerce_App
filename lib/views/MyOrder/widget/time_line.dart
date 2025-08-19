import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/constants/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimeLineWidget extends StatelessWidget {
  const TimeLineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final timelineEntries = [
      {
        'title': 'Order Placed',
        'description': 'We have received your order',
        'isFirst': true,
        'isLast': false,
      },
      {
        'title': 'Order Confirmed',
        'description': 'We have confirmed your order',
        'isFirst': false,
        'isLast': false,
      },
      {
        'title': 'Order Shipped',
        'description': 'We have shipped your order',
        'isFirst': false,
        'isLast': true,
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      itemCount: timelineEntries.length,
      itemBuilder: (context, index) {
        final entry = timelineEntries[index];
        return TimelineTile(
          alignment: TimelineAlign.start,
          lineXY: 0.1,
          isFirst: entry['isFirst'] as bool,
          isLast: entry['isLast'] as bool,
          indicatorStyle: IndicatorStyle(
            width: 30,
            color: AppColors.black,
            iconStyle: IconStyle(
              iconData: Icons.check,
              color: entry['isFirst'] as bool
                  ? AppColors.white
                  : AppColors.white,
            ),
          ),
          beforeLineStyle: LineStyle(color: AppColors.black, thickness: 3),
          afterLineStyle: LineStyle(color: AppColors.black, thickness: 3),
          endChild: _buildTimelineCard(
            context: context,
            title: entry['title'] as String,
            description: entry['description'] as String,
          ),
        );
      },
    );
  }

  Widget _buildTimelineCard({
    required BuildContext context,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        constraints: const BoxConstraints(minHeight: 40),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                  fontSize: 16.sp,
                ),
              ),
              verticalSpace(8),
              Text(
                description,
                style: TextStyle(color: AppColors.gray, fontSize: 12.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
