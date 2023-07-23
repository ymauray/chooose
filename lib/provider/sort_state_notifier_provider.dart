import 'dart:math';

import 'package:chooose/model/item.dart';
import 'package:chooose/model/pair.dart';
import 'package:chooose/model/sort_state.dart';
import 'package:chooose/provider/items_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sort_state_notifier_provider.g.dart';

class Finished extends Error {}

@Riverpod()
class SortStateNotifier extends _$SortStateNotifier {
  late Pair currentPair;

  @override
  SortState build(List<Item> items) {
    for (final item in items) {
      item.score = 0;
    }
    final pairs = <Pair>[];
    for (var i = 0; i < items.length; i++) {
      for (var j = i + 1; j < items.length; j++) {
        pairs.add(Pair(items[i], items[j]));
      }
    }

    final s = _advance(
      SortState(
        step: 0,
        steps: pairs.length,
        pairs: pairs,
        items: items,
      ),
    );

    return s;
  }

  SortState _advance(SortState state) {
    if (state.pairs.isEmpty) throw Finished();
    final pos = Random().nextInt(state.pairs.length);
    currentPair = state.pairs[pos];
    return state.copyWith(
      step: state.step + 1,
      pairs: state.pairs
          .where(
            (element) =>
                element.a.label != currentPair.a.label ||
                element.b.label != currentPair.b.label,
          )
          .toList(),
    );
  }

  Item get a => currentPair.a;
  Item get b => currentPair.b;

  bool chooseA() {
    return _resolve(currentPair.a, currentPair.b);
  }

  bool chooseB() {
    return _resolve(currentPair.b, currentPair.a);
  }

  bool _resolve(Item highPriority, Item lowPriority) {
    var D = highPriority.ranking - lowPriority.ranking;
    if (D.abs() > 400) D = D.sign * 400;
    final p = 1 / (1 + pow(10, -D / 400));
    final rdiff = 40 * (1 - p);
    highPriority.score += rdiff.toInt();
    lowPriority.score -= rdiff.toInt();
    try {
      state = _advance(state);
      return true;
    } catch (e) {
      return false;
    }
  }

  FutureOr<void> finalize() async {
    for (final item in state.items) {
      item.ranking += item.score;
    }
    await ref.read(itemsProvider.notifier).writeItems(state.items);
    await ref.read(itemsProvider.notifier).refresh();
  }
}
