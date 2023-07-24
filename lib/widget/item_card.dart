import 'package:chooose/l10n/l10n_extension.dart';
import 'package:chooose/model/item.dart';
import 'package:chooose/provider/items_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemCard extends ConsumerWidget {
  const ItemCard({
    required this.item,
    required this.max,
    super.key,
  });

  final Item item;
  final int max;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: ValueKey(item.label),
      direction: DismissDirection.endToStart,
      background: ColoredBox(
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                context.t.delete,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      dismissThresholds: const {
        DismissDirection.endToStart: 0.33,
      },
      confirmDismiss: (direction) async => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(context.t.deleteThisElement),
          content: Text(context.t.thisActionCannotBeUndone),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(context.t.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(context.t.delete),
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        ref.read(itemsProvider.notifier).removeItem(item);
      },
      child: ListTile(
        title: Text(item.label),
        trailing: Text(
          '${100 * item.ranking ~/ max} %',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
