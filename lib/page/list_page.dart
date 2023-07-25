import 'package:chooose/l10n/l10n_extension.dart';
import 'package:chooose/model/item_list.dart';
import 'package:chooose/page/sort_page.dart';
import 'package:chooose/provider/item_lists_provider.dart';
import 'package:chooose/widget/item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListPage extends ConsumerWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = ModalRoute.of(context)!.settings.arguments as ItemList;
    final label = args.label;
    final listsAsync = ref.watch(itemListsProvider);
    final lists = listsAsync.valueOrNull;
    final list = lists!.firstWhere((element) => element.label == label);
    final items = list.items;
    final max = items.firstOrNull?.ranking;

    return Scaffold(
      appBar: AppBar(
        title: Text(list.label),
        actions: [
          IconButton(
            onPressed: () {
              if (items.isEmpty) {
                return;
              }
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => SortPage(label, items),
                ),
              );
            },
            icon: const Icon(Icons.play_arrow),
          ),
        ],
      ),
      body: ListView.separated(
        itemBuilder: (context, index) =>
            ItemCard(label: label, item: items[index], max: max!),
        separatorBuilder: (context, index) => const Divider(
          height: 1,
        ),
        itemCount: items.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => showForm(context, ref, list.label),
        tooltip: context.t.addElement,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> showForm(
    BuildContext context,
    WidgetRef ref,
    String label,
  ) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        final controller = TextEditingController();
        return AlertDialog(
          title: Text(context.t.addElement),
          content: TextField(
            autofocus: true,
            controller: controller,
            decoration: InputDecoration(
              hintText: context.t.name,
            ),
            textCapitalization: TextCapitalization.sentences,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(context.t.cancel),
            ),
            TextButton(
              onPressed: () {
                ref
                    .read(itemListsProvider.notifier)
                    .addItem(label, controller.text);
                Navigator.of(context).pop();
              },
              child: Text(context.t.add),
            ),
          ],
        );
      },
    );
  }
}
