import 'package:math_expressions/math_expressions.dart';

class CalculatorEngine {
  const CalculatorEngine._();

  /// Evaluates the math expression securely
  static String evaluate(String expression) {
    if (expression.isEmpty) return '0';

    try {
      // Sanitize the expression for the parser
      String sanitized = expression
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('−', '-')
          .replaceAll('π', '3.141592653589793')
          .replaceAll('e', '2.718281828459045');

      // Add implicit multiplication for percentages, e.g., "50%" -> "50/100"
      sanitized = sanitized.replaceAll('%', '/100');

      Parser p = Parser();
      Expression exp = p.parse(sanitized);
      ContextModel cm = ContextModel();

      double eval = exp.evaluate(EvaluationType.REAL, cm);

      // Handle Infinity or NaN errors
      if (eval.isInfinite || eval.isNaN) {
        throw Exception('Math Error');
      }

      // Format result: remove decimal if it's a whole number
      String resultStr = eval.toString();
      if (resultStr.endsWith('.0')) {
        resultStr = resultStr.substring(0, resultStr.length - 2);
      }

      return resultStr;
    } catch (e) {
      return 'Error'; // Graceful error boundary instead of crashing
    }
  }
}
