import '../repositories/history_repository.dart';

class ClearHistoryUseCase {
  final HistoryRepository repository;

  const ClearHistoryUseCase(this.repository);

  Future<void> call() async {
    return await repository.clearHistory();
  }
}
