import 'package:chooose/l10n/l10n_extension.dart';
import 'package:chooose/provider/item_lists_provider.dart';
import 'package:chooose/widget/list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncLists = ref.watch(itemListsProvider);
    final lists = asyncLists.valueOrNull;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.yourLists),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => ListCard(list: lists![index]),
        separatorBuilder: (context, index) => const Divider(
          height: 1,
        ),
        itemCount: asyncLists.valueOrNull?.length ?? 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => showForm(context, ref),
        tooltip: context.t.addElement,
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
          title: Text(context.t.addList),
          content: TextField(
            autofocus: true,
            controller: controller,
            decoration: InputDecoration(
              labelText: context.t.name,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: Text(context.t.cancel),
            ),
            TextButton(
              onPressed: () async {
                await ref
                    .read(itemListsProvider.notifier)
                    .addList(controller.text);
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
