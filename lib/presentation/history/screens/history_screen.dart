import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/history_provider.dart';
import '../widgets/history_list_item.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyState = ref.watch(historyNotifierProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep_rounded),
            tooltip: 'Clear All History',
            onPressed: () => _showClearDialog(context, ref),
          ),
        ],
      ),
      body: historyState.when(
        data: (historyList) {
          if (historyList.isEmpty) {
            return Center(
              child: Text(
                'No History Yet',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.5),
                ),
              ),
            );
          }

          // ListView.builder ensures lazy loading for massive data (infinite scroll)
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: historyList.length,
            itemBuilder: (context, index) {
              final item = historyList[index];
              return HistoryListItem(
                item: item,
                onDelete: () {
                  if (item.id != null) {
                    ref.read(historyNotifierProvider.notifier).deleteItem(item.id!);
                  }
                },
                onTap: () {
                  // Optional: Can copy result back to calculator screen
                  Navigator.pop(context, item.result);
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text(
            'Failed to load history.',
            style: TextStyle(color: theme.colorScheme.error),
          ),
        ),
      ),
    );
  }

  void _showClearDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear History'),
        content: const Text('Are you sure you want to delete all offline history? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              ref.read(historyNotifierProvider.notifier).clearAll();
              Navigator.pop(ctx);
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}
