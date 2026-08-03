import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/theme/app_theme.dart';
import 'core/error/error_boundary.dart';
import 'data/datasources/local/isar_database.dart';
import 'presentation/calculator/screens/calculator_screen.dart';

void main() async {
  ErrorBoundary.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  await IsarDatabase.initialize();
  runApp(const ProviderScope(child: CalculatorApp()));
}

// ... बाकी का कोड (CalculatorApp क्लास) इसके नीचे लिखें
