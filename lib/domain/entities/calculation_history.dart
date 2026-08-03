class CalculationHistory {
  final int? id;
  final String expression;
  final String result;
  final DateTime timestamp;

  const CalculationHistory({
    this.id,
    required this.expression,
    required this.result,
    required this.timestamp,
  });
}
