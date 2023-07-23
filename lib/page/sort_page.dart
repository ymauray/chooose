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
      child: Text(
        sortStateNotifier.a.label,
      ),
    );

    final buttonB = ElevatedButton(
      onPressed: () async {
        if (!sortStateNotifier.chooseB()) {
          await sortStateNotifier.finalize();
          Navigator.of(context).pop();
        }
      },
      child: Text(
        sortStateNotifier.b.label,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Chooose - Sort'),
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
          Center(child: Text('Step ${sortState.step} of ${sortState.steps}')),
          const Divider(),
          Center(
            child: reverse ? buttonB : buttonA,
          ),
          const Center(child: Text('versus')),
          Center(
            child: reverse ? buttonA : buttonB,
          ),
        ],
      ),
    );
  }
}
