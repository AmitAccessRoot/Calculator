import '../entities/calculation_history.dart';
import '../repositories/history_repository.dart';

class SaveCalculationUseCase {
  final HistoryRepository repository;

  const SaveCalculationUseCase(this.repository);

  Future<void> call(CalculationHistory history) async {
    return await repository.saveCalculation(history);
  }
}
