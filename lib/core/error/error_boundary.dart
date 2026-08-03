import 'dart:ui';
import 'package:flutter/material.dart';

class ErrorBoundary {
  const ErrorBoundary._();

  static void initialize() {
    // Catch Flutter framework errors
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      // In a production app, you can log this to a secure local file
      debugPrint('Flutter Error Caught: ${details.exceptionAsString()}');
    };

    // Catch asynchronous Dart errors (Isolates, Futures)
    PlatformDispatcher.instance.onError = (Object error, StackTrace stackTrace) {
      debugPrint('Platform Error Caught: $error');
      return true; // Prevents the app from crashing completely
    };

    // Replace the Red Screen of Death with a graceful fallback native UI
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return const GracefulFallbackWidget();
    };
  }
}

class GracefulFallbackWidget extends StatelessWidget {
  const GracefulFallbackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: Theme.of(context).colorScheme.error,
                  size: 64,
                ),
                const SizedBox(height: 16),
                Text(
                  'Something went wrong.',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'The application recovered successfully. Please try again.',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
