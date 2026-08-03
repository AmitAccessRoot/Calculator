import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/dependency_providers.dart';
import '../../../domain/entities/calculation_history.dart';

final historyNotifierProvider = 
    StateNotifierProvider<HistoryNotifier, AsyncValue<List<CalculationHistory>>>((ref) {
  return HistoryNotifier(
    ref.read(getHistoryUseCaseProvider),
    ref.read(clearHistoryUseCaseProvider),
    ref.read(deleteCalculationUseCaseProvider),
  );
});

class HistoryNotifier extends StateNotifier<AsyncValue<List<CalculationHistory>>> {
  final GetHistoryUseCase _getHistory;
  final ClearHistoryUseCase _clearHistory;
  final DeleteCalculationUseCase _deleteCalculation;

  HistoryNotifier(this._getHistory, this._clearHistory, this._deleteCalculation) 
      : super(const AsyncValue.loading()) {
    loadHistory();
  }

  Future<void> loadHistory() async {
    try {
      state = const AsyncValue.loading();
      final historyList = await _getHistory();
      state = AsyncValue.data(historyList);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> clearAll() async {
    try {
      await _clearHistory();
      state = const AsyncValue.data([]); // Update UI instantly
    } catch (e) {
      // In production, show a native SnackBar using a global key
    }
  }

  Future<void> deleteItem(int id) async {
    try {
      await _deleteCalculation(id);
      // Reload history to refresh the list without mutating the state directly
      await loadHistory();
    } catch (e) {
      // Ignore gracefully to prevent app crash
    }
  }
}
