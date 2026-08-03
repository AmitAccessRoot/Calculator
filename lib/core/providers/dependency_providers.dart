import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/local/history_local_datasource.dart';
import '../../data/repositories/history_repository_impl.dart';
import '../../domain/repositories/history_repository.dart';
import '../../domain/usecases/clear_history_usecase.dart';
import '../../domain/usecases/get_history_usecase.dart';
import '../../domain/usecases/save_calculation_usecase.dart';

// Data Source Provider
final historyLocalDataSourceProvider = Provider<HistoryLocalDataSource>((ref) {
  return HistoryLocalDataSourceImpl();
});

// Repository Provider
final historyRepositoryProvider = Provider<HistoryRepository>((ref) {
  final localDataSource = ref.read(historyLocalDataSourceProvider);
  return HistoryRepositoryImpl(localDataSource);
});

// Usecases Providers
final saveCalculationUseCaseProvider = Provider<SaveCalculationUseCase>((ref) {
  return SaveCalculationUseCase(ref.read(historyRepositoryProvider));
});

final getHistoryUseCaseProvider = Provider<GetHistoryUseCase>((ref) {
  return GetHistoryUseCase(ref.read(historyRepositoryProvider));
});

final clearHistoryUseCaseProvider = Provider<ClearHistoryUseCase>((ref) {
  return ClearHistoryUseCase(ref.read(historyRepositoryProvider));
});

// (Keep all previous code as it is in dependency_providers.dart)
// Add this new provider at the end:

import '../../domain/usecases/delete_calculation_usecase.dart';

final deleteCalculationUseCaseProvider = Provider<DeleteCalculationUseCase>((ref) {
  return DeleteCalculationUseCase(ref.read(historyRepositoryProvider));
});
