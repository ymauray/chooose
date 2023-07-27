import 'package:chooose/l10n/l10n_extension.dart';
import 'package:chooose/model/item_list.dart';
import 'package:chooose/page/sort_page.dart';
import 'package:chooose/provider/item_lists_provider.dart';
import 'package:chooose/widget/custom_app_bar.dart';
import 'package:chooose/widget/item_card.dart';
import 'package:chooose/widget/item_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      appBar: CustomAppBar(
        title: Text(list.label),
        actions: [
          IconButton(
            onPressed: () async => await showDialog<void>(
              context: context,
              builder: (context) {
                return ItemForm(label);
              },
            ),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _Onboarding(),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) =>
                  ItemCard(label: label, item: items[index], max: max!),
              separatorBuilder: (context, index) => const Divider(
                height: 1,
              ),
              itemCount: items.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        onPressed: () {
          if (items.length < 2) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(context.t.needTwoElements),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (context) => SortPage(label, items),
            ),
          );
        },
        tooltip: context.t.sort,
        child: const Icon(Icons.play_arrow),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _Onboarding extends ConsumerWidget {
  const _Onboarding();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(itemListsProvider);

    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();
        if (snapshot.data!.getBool('onboardingElements') ?? false) {
          return Container();
        }
        return Column(
          children: [
            ListTile(
              tileColor: Theme.of(context).colorScheme.background,
              title: Text(
                context.t.onboardingElements,
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
                  await snapshot.data!.setBool('onboardingElements', true);
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
