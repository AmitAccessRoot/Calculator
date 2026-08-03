import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/theme/app_theme.dart';
import 'core/error/error_boundary.dart';
import 'data/datasources/local/isar_database.dart';

void main() async {
  // Setup global error boundaries to prevent app crash
  ErrorBoundary.initialize();

  try {
    WidgetsFlutterBinding.ensureInitialized();
    
    // Initialize Local Database securely before UI loads
    await IsarDatabase.initialize();
    
    runApp(
      const ProviderScope(
        child: CalculatorApp(),
      ),
    );
  } catch (e, stack) {
    debugPrint('App initialization failed: $e');
    // If initialization fails completely, show fallback natively
    runApp(const MaterialApp(home: GracefulFallbackWidget()));
  }
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Offline Calculator',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: const PlaceholderScreen(),
        );
      },
    );
  }
}

// Other imports remain the same...
import 'presentation/calculator/screens/calculator_screen.dart';

// main() and CalculatorApp class remain exactly the same as in Level 2...

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Offline Calculator',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: const CalculatorScreen(), // Replaced Placeholder with Real Screen
        );
      },
    );
  }
}
