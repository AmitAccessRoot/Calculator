import 'package:isar/isar.dart';
import '../../domain/entities/calculation_history.dart';

part 'calculation_history_model.g.dart';

@collection
class CalculationHistoryModel {
  Id id = Isar.autoIncrement;

  late String expression;
  late String result;
  late DateTime timestamp;

  // Converts Domain Entity to Data Model
  static CalculationHistoryModel fromEntity(CalculationHistory entity) {
    return CalculationHistoryModel()
      ..expression = entity.expression
      ..result = entity.result
      ..timestamp = entity.timestamp;
  }

  // Converts Data Model back to Domain Entity
  CalculationHistory toEntity() {
    return CalculationHistory(
      id: id,
      expression: expression,
      result: result,
      timestamp: timestamp,
    );
  }
}
