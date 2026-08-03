import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Isar database initialization will be added here in Level 2
  
  runApp(
    const ProviderScope(
      child: CalculatorApp(),
    ),
  );
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ScreenUtilInit ensures the UI scales perfectly on mobile and tablets
    return ScreenUtilInit(
      designSize: const Size(390, 844), // Standard HD base size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Offline Calculator',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system, // Automatically adapts to native system theme
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: const PlaceholderScreen(), // Placeholder until Level 5
        );
      },
    );
  }
}

// Temporary screen to verify the setup
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator HD'),
      ),
      body: Center(
        child: Text(
          'Level 1 Completed Successfully',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
