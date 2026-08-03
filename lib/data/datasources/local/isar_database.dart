import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatabase {
  static late final Isar _instance;
  
  static Isar get instance => _instance;

  /// Initializes the Isar local database instances
  static Future<void> initialize() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      
      // Prevent multiple initialization in case of hot restarts
      if (Isar.instanceNames.isEmpty) {
        _instance = await Isar.open(
          [], // TODO: Schemas will be injected here in Level 3
          directory: dir.path,
          name: 'calculator_db',
        );
      } else {
        _instance = Isar.getInstance('calculator_db')!;
      }
    } catch (e) {
      // Throwing error here will be caught by ErrorBoundary in main.dart
      throw Exception('Failed to initialize Isar Database: $e');
    }
  }
}
