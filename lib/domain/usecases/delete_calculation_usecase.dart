import '../repositories/history_repository.dart';

class DeleteCalculationUseCase {
  final HistoryRepository repository;

  const DeleteCalculationUseCase(this.repository);

  Future<void> call(int id) async {
    return await repository.deleteCalculation(id);
  }
}
