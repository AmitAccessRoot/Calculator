import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../providers/calculator_notifier.dart';
import '../widgets/calc_button.dart';
import '../widgets/display_panel.dart';

class CalculatorScreen extends ConsumerWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(calculatorNotifierProvider);
    final notifier = ref.read(calculatorNotifierProvider.notifier);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        actions: [
          IconButton(
            icon: Icon(
              state.isScientificMode ? Icons.science : Icons.science_outlined,
              color: state.isScientificMode ? AppColors.operatorColor : null,
            ),
            onPressed: notifier.toggleMode,
            tooltip: 'Toggle Scientific Mode',
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              // History screen navigation will be implemented in Level 6
            },
            tooltip: 'View History',
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(
              flex: 2,
              child: DisplayPanel(),
            ),
            // Divider to separate display from keypad
            Divider(color: theme.dividerTheme.color, thickness: 1, height: 1),
            // Keypad Area
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Smooth Animated Scientific Keypad
                    AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: state.isScientificMode
                          ? _buildScientificRow(notifier, theme)
                          : const SizedBox.shrink(),
                    ),
                    _buildRow(['AC', '⌫', '%', '÷'], notifier, theme),
                    _buildRow(['7', '8', '9', '×'], notifier, theme),
                    _buildRow(['4', '5', '6', '−'], notifier, theme),
                    _buildRow(['1', '2', '3', '+'], notifier, theme),
                    // Bottom row with wide zero button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CalcButton(text: '0', isWide: true, onTap: () => notifier.onKeyPress('0')),
                        CalcButton(text: '.', onTap: () => notifier.onKeyPress('.')),
                        CalcButton(
                          text: '=',
                          backgroundColor: AppColors.equalButtonColor,
                          textColor: Colors.white,
                          onTap: notifier.calculateResult,
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build standard rows
  Widget _buildRow(List<String> buttons, CalculatorNotifier notifier, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: buttons.map((btn) {
        Color? bgColor;
        Color? textColor;

        if (['÷', '×', '−', '+'].contains(btn)) {
          textColor = AppColors.operatorColor;
        } else if (btn == 'AC' || btn == '⌫' || btn == '%') {
          textColor = theme.colorScheme.error;
        }

        return CalcButton(
          text: btn,
          backgroundColor: bgColor,
          textColor: textColor,
          onTap: () {
            if (btn == 'AC') {
              notifier.clearAll();
            } else if (btn == '⌫') {
              notifier.deleteLast();
            } else {
              notifier.onKeyPress(btn);
            }
          },
        );
      }).toList(),
    );
  }

  // Helper method to build scientific options
  Widget _buildScientificRow(CalculatorNotifier notifier, ThemeData theme) {
    final scientificOps = ['sin(', 'cos(', 'tan(', '^', '√(', 'π', 'e'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: scientificOps.map((op) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: CalcButton(
              text: op.replaceAll('(', ''),
              textColor: theme.colorScheme.primary,
              onTap: () => notifier.onKeyPress(op),
            ),
          );
        }).toList(),
      ),
    );
  }
}
