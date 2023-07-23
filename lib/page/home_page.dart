import 'package:chooose/page/sort_page.dart';
import 'package:chooose/provider/items_provider.dart';
import 'package:chooose/widget/item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItems = ref.watch(itemsProvider);
    final items = asyncItems.valueOrNull;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choooose'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => SortPage(items!),
                ),
              );
            },
            icon: const Icon(Icons.play_arrow),
          ),
        ],
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => ItemCard(item: items![index]),
        separatorBuilder: (context, index) => const Divider(
          height: 1,
        ),
        itemCount: asyncItems.valueOrNull?.length ?? 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => showForm(context, ref),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> showForm(BuildContext context, WidgetRef ref) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        final controller = TextEditingController();
        return AlertDialog(
          title: const Text('Add item'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Enter item name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                ref.read(itemsProvider.notifier).addItem(controller.text);
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
