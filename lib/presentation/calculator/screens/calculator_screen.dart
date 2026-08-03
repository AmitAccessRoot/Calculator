import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../history/screens/history_screen.dart';
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
          // Toggle Scientific Mode Button
          IconButton(
            icon: Icon(
              state.isScientificMode ? Icons.science : Icons.science_outlined,
              color: state.isScientificMode ? AppColors.operatorColor : null,
            ),
            onPressed: notifier.toggleMode,
            tooltip: 'Toggle Scientific Mode',
          ),
          
          // History Button with secure navigation
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'View History',
            onPressed: () async {
              // Navigate strictly without external routing packages
              final pastedResult = await Navigator.push<String?>(
                context,
                MaterialPageRoute(builder: (context) => const HistoryScreen()),
              );

              // If user taps an old calculation, paste the result into the current state smoothly
              if (pastedResult != null && pastedResult.isNotEmpty) {
                Future.delayed(const Duration(milliseconds: 300), () {
                  for (var char in pastedResult.split('')) {
                    notifier.onKeyPress(char);
                  }
                });
              }
            },
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Top Display Panel
            const Expanded(
              flex: 2,
              child: DisplayPanel(),
            ),
            
            // Divider to cleanly separate display from keypad
            Divider(color: theme.dividerTheme.color, thickness: 1, height: 1),
            
            // Keypad Area
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Smooth Animated Scientific Keypad (120 FPS transition)
                    AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: state.isScientificMode
                          ? _buildScientificRow(notifier, theme)
                          : const SizedBox.shrink(),
                    ),
                    
                    // Basic Keypad Rows
                    _buildRow(['AC', '⌫', '%', '÷'], notifier, theme),
                    _buildRow(['7', '8', '9', '×'], notifier, theme),
                    _buildRow(['4', '5', '6', '−'], notifier, theme),
                    _buildRow(['1', '2', '3', '+'], notifier, theme),
                    
                    // Bottom row with wide zero button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CalcButton(
                          text: '0', 
                          isWide: true, 
                          onTap: () => notifier.onKeyPress('0')
                        ),
                        CalcButton(
                          text: '.', 
                          onTap: () => notifier.onKeyPress('.')
                        ),
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

  // Helper method to build standard standard calculator rows
  Widget _buildRow(List<String> buttons, CalculatorNotifier notifier, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: buttons.map((btn) {
        Color? bgColor;
        Color? textColor;

        // Apply custom colors for operators and action buttons
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

  // Helper method to build scientific options row dynamically
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
              text: op.replaceAll('(', ''), // Display nicely without bracket on button
              textColor: theme.colorScheme.primary,
              onTap: () => notifier.onKeyPress(op),
            ),
          );
        }).toList(),
      ),
    );
  }
}          return Padding(
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
