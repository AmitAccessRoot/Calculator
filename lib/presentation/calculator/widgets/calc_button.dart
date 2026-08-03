import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CalcButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isWide; // For the '0' button to span two columns

  const CalcButton({
    super.key,
    required this.text,
    required this.onTap,
    this.backgroundColor,
    this.textColor,
    this.isWide = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultBgColor = theme.colorScheme.surface;
    final defaultTextColor = theme.colorScheme.onSurface;

    return Container(
      margin: EdgeInsets.all(6.w),
      width: isWide ? 162.w : 75.w,
      height: 75.h,
      decoration: BoxDecoration(
        color: backgroundColor ?? defaultBgColor,
        borderRadius: BorderRadius.circular(40.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(40.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(40.r),
          onTap: onTap,
          splashColor: theme.primaryColor.withOpacity(0.2),
          highlightColor: theme.primaryColor.withOpacity(0.1),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'AppFont',
                fontSize: 28.sp,
                fontWeight: FontWeight.w500,
                color: textColor ?? defaultTextColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
