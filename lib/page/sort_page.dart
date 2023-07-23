import 'dart:math';

import 'package:chooose/model/item.dart';
import 'package:chooose/provider/sort_state_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SortPage extends ConsumerWidget {
  const SortPage(this.items, {super.key});

  final List<Item> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sortState = ref.watch(sortStateNotifierProvider(items));
    final sortStateNotifier =
        ref.watch(sortStateNotifierProvider(items).notifier);
    final reverse = Random().nextBool();

    final buttonA = ElevatedButton(
      onPressed: () async {
        if (!sortStateNotifier.chooseA()) {
          await sortStateNotifier.finalize();
          Navigator.of(context).pop();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Text(
          sortStateNotifier.a.label,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );

    final buttonB = ElevatedButton(
      onPressed: () async {
        if (!sortStateNotifier.chooseB()) {
          await sortStateNotifier.finalize();
          Navigator.of(context).pop();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Text(
          sortStateNotifier.b.label,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Choooose - Sort'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.cancel),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Etape ${sortState.step} de ${sortState.steps}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Divider(),
          ),
          Center(
            child: Text(
              'Vous préférez :',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Center(
            child: reverse ? buttonB : buttonA,
          ),
          const SizedBox(
            height: 16,
          ),
          Center(
            child: Text(
              'ou',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Center(
            child: reverse ? buttonA : buttonB,
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
