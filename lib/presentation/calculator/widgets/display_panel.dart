import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../providers/calculator_notifier.dart';

class DisplayPanel extends ConsumerWidget {
  const DisplayPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(calculatorNotifierProvider);
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      alignment: Alignment.bottomRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Scrollable Expression Text
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true, // Auto-scroll to the end
            physics: const BouncingScrollPhysics(),
            child: Text(
              state.expression,
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 36.sp,
                color: theme.colorScheme.onSurface.withOpacity(0.7),
                letterSpacing: 1.5,
              ),
              maxLines: 1,
            ),
          ),
          SizedBox(height: 16.h),
          // Scrollable Result Text
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            physics: const BouncingScrollPhysics(),
            child: Text(
              state.hasError ? 'Error' : state.result,
              style: theme.textTheme.displayLarge?.copyWith(
                fontSize: 56.sp,
                color: state.hasError 
                    ? theme.colorScheme.error 
                    : theme.colorScheme.onSurface,
              ),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
