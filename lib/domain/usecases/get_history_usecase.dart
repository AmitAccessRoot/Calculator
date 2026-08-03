import '../entities/calculation_history.dart';
import '../repositories/history_repository.dart';

class GetHistoryUseCase {
  final HistoryRepository repository;

  const GetHistoryUseCase(this.repository);

  Future<List<CalculationHistory>> call() async {
    return await repository.getHistory();
  }
}
