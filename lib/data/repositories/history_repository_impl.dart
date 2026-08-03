import '../../domain/entities/calculation_history.dart';
import '../../domain/repositories/history_repository.dart';
import '../datasources/local/history_local_datasource.dart';
import '../models/calculation_history_model.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryLocalDataSource localDataSource;

  const HistoryRepositoryImpl(this.localDataSource);

  @override
  Future<List<CalculationHistory>> getHistory() async {
    final models = await localDataSource.getAllHistory();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> saveCalculation(CalculationHistory history) async {
    final model = CalculationHistoryModel.fromEntity(history);
    await localDataSource.saveHistory(model);
  }

  @override
  Future<void> clearHistory() async {
    await localDataSource.clearAllHistory();
  }

  @override
  Future<void> deleteCalculation(int id) async {
    await localDataSource.deleteHistoryById(id);
  }
}
