import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../models/calculation_history_model.dart';

class IsarDatabase {
  static late final Isar _instance;
  
  static Isar get instance => _instance;

  static Future<void> initialize() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      
      if (Isar.instanceNames.isEmpty) {
        _instance = await Isar.open(
          [CalculationHistoryModelSchema], // Schema added here
          directory: dir.path,
          name: 'calculator_db',
        );
      } else {
        _instance = Isar.getInstance('calculator_db')!;
      }
    } catch (e) {
      throw Exception('Failed to initialize Isar Database: $e');
    }
  }
}
