import 'dart:isolate';

class IsolateHelper {
  const IsolateHelper._();

  /// Offloads heavy computation to a background isolate to keep the UI butter smooth.
  /// [computation] is the heavy function to run.
  /// [message] is the data to pass to the function.
  static Future<R> runHeavyTask<T, R>(R Function(T) computation, T message) async {
    try {
      return await Isolate.run(() => computation(message));
    } catch (e) {
      throw Exception('Isolate execution failed: $e');
    }
  }
}
