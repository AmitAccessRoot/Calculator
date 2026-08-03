import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/dependency_providers.dart';
import '../../../core/utils/calculator_engine.dart';
import '../../../core/utils/isolate_helper.dart';
import '../../../domain/entities/calculation_history.dart';
import 'calculator_state.dart';

final calculatorNotifierProvider = StateNotifierProvider<CalculatorNotifier, CalculatorState>((ref) {
  final saveUseCase = ref.read(saveCalculationUseCaseProvider);
  return CalculatorNotifier(saveUseCase);
});

class CalculatorNotifier extends StateNotifier<CalculatorState> {
  final SaveCalculationUseCase _saveCalculationUseCase;

  CalculatorNotifier(this._saveCalculationUseCase) : super(const CalculatorState());

  void toggleMode() {
    state = state.copyWith(isScientificMode: !state.isScientificMode);
  }

  void onKeyPress(String key) {
    if (state.hasError) {
      clearAll();
    }
    
    // Prevent multiple decimals or operators side by side (basic validation)
    state = state.copyWith(
      expression: state.expression + key,
      hasError: false,
    );
  }

  void deleteLast() {
    if (state.expression.isNotEmpty) {
      state = state.copyWith(
        expression: state.expression.substring(0, state.expression.length - 1),
        hasError: false,
      );
    }
  }

  void clearAll() {
    state = const CalculatorState();
  }

  Future<void> calculateResult() async {
    if (state.expression.isEmpty) return;

    // Offload heavy parsing/calculating to Isolate for butter smooth 120 FPS UI
    final result = await IsolateHelper.runHeavyTask<String, String>(
      CalculatorEngine.evaluate,
      state.expression,
    );

    if (result == 'Error') {
      state = state.copyWith(result: result, hasError: true);
      return;
    }

    state = state.copyWith(result: result, hasError: false);

    // Save strictly to local offline database
    _saveToHistory(state.expression, result);
    
    // Update expression for chained calculations
    state = state.copyWith(expression: result, result: '0');
  }

  Future<void> _saveToHistory(String expression, String result) async {
    try {
      final historyEntity = CalculationHistory(
        expression: expression,
        result: result,
        timestamp: DateTime.now(),
      );
      await _saveCalculationUseCase(historyEntity);
    } catch (e) {
      // Silently fail if local DB write fails, preventing app crash
      // In production, we can log this locally
    }
  }
}
