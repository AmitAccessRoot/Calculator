class CalculatorState {
  final String expression;
  final String result;
  final bool isScientificMode;
  final bool hasError;

  const CalculatorState({
    this.expression = '',
    this.result = '0',
    this.isScientificMode = false,
    this.hasError = false,
  });

  CalculatorState copyWith({
    String? expression,
    String? result,
    bool? isScientificMode,
    bool? hasError,
  }) {
    return CalculatorState(
      expression: expression ?? this.expression,
      result: result ?? this.result,
      isScientificMode: isScientificMode ?? this.isScientificMode,
      hasError: hasError ?? this.hasError,
    );
  }
}
