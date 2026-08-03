import 'package:isar/isar.dart';
import '../../../core/error/failures.dart';
import '../../models/calculation_history_model.dart';
import 'isar_database.dart';

abstract class HistoryLocalDataSource {
  Future<List<CalculationHistoryModel>> getAllHistory();
  Future<void> saveHistory(CalculationHistoryModel model);
  Future<void> clearAllHistory();
  Future<void> deleteHistoryById(int id);
}

class HistoryLocalDataSourceImpl implements HistoryLocalDataSource {
  Isar get _isar => IsarDatabase.instance;

  @override
  Future<List<CalculationHistoryModel>> getAllHistory() async {
    try {
      // Fetching all records sorted by latest first
      return await _isar.calculationHistoryModels
          .where()
          .sortByTimestampDesc()
          .findAll();
    } catch (e) {
      throw const DatabaseFailure('Failed to fetch calculation history from database.');
    }
  }

  @override
  Future<void> saveHistory(CalculationHistoryModel model) async {
    try {
      await _isar.writeTxn(() async {
        await _isar.calculationHistoryModels.put(model);
      });
    } catch (e) {
      throw const DatabaseFailure('Failed to save calculation history.');
    }
  }

  @override
  Future<void> clearAllHistory() async {
    try {
      await _isar.writeTxn(() async {
        await _isar.calculationHistoryModels.clear();
      });
    } catch (e) {
      throw const DatabaseFailure('Failed to clear database.');
    }
  }

  @override
  Future<void> deleteHistoryById(int id) async {
    try {
      await _isar.writeTxn(() async {
        await _isar.calculationHistoryModels.delete(id);
      });
    } catch (e) {
      throw const DatabaseFailure('Failed to delete specific history item.');
    }
  }
}
