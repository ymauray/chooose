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
      background: const ColoredBox(
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Supprimer',
                style: TextStyle(
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
          title: const Text('Supprimer cet élément ?'),
          content: const Text('Cette action est irréversible.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Supprimer'),
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
