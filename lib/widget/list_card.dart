import 'package:chooose/l10n/l10n_extension.dart';
import 'package:chooose/model/item_list.dart';
import 'package:chooose/provider/item_lists_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListCard extends ConsumerWidget {
  const ListCard({
    required this.list,
    super.key,
  });

  final ItemList list;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: ValueKey(list.label),
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
        ref.read(itemListsProvider.notifier).removeList(list);
      },
      child: ListTile(
        title: Text(list.label),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.of(context).pushNamed('/list', arguments: list),
      ),
    );
  }
}
