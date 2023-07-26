import 'package:chooose/l10n/l10n_extension.dart';
import 'package:chooose/provider/item_lists_provider.dart';
import 'package:chooose/widget/list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _Onboarding(),
          const Divider(
            height: 1,
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => ListCard(list: lists![index]),
              separatorBuilder: (context, index) => const Divider(
                height: 1,
              ),
              itemCount: asyncLists.valueOrNull?.length ?? 0,
            ),
          ),
        ],
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
            textCapitalization: TextCapitalization.sentences,
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

class _Onboarding extends ConsumerWidget {
  const _Onboarding();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncLists = ref.watch(itemListsProvider);

    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();
        if (snapshot.data!.getBool('onboardingLists') ?? false) {
          return Container();
        }
        return Column(
          children: [
            ListTile(
              tileColor: Theme.of(context).colorScheme.background,
              title: Text(
                context.t.onboardingLists,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              trailing: IconButton(
                splashRadius: 0.00001,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 24, maxWidth: 24),
                onPressed: () async {
                  await snapshot.data!.setBool('onboardingLists', true);
                  await ref.read(itemListsProvider.notifier).reload();
                },
                icon: const Icon(Icons.close),
              ),
            ),
          ],
        );
      },
    );
  }
}
