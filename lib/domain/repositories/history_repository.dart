import '../entities/calculation_history.dart';

abstract class HistoryRepository {
  Future<List<CalculationHistory>> getHistory();
  Future<void> saveCalculation(CalculationHistory history);
  Future<void> clearHistory();
  Future<void> deleteCalculation(int id);
}
