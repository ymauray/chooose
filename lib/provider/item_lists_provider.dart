import 'dart:convert';
import 'dart:io';

import 'package:chooose/model/item.dart';
import 'package:chooose/model/item_list.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'item_lists_provider.g.dart';

@riverpod
class ItemLists extends _$ItemLists {
  @override
  FutureOr<List<ItemList>> build() async {
    return loadLists();
  }

  FutureOr<File> getFile() async {
    final localPath = await getApplicationDocumentsDirectory();
    final file = File('${localPath.path}/lists.json');
    return file;
  }

  FutureOr<List<ItemList>> loadLists() async {
    final file = await getFile();
    if (!file.existsSync()) {
      return [];
    }

    final content = file.readAsStringSync();
    final jsonContent = jsonDecode(content) as List<dynamic>;
    final lists = jsonContent
        .map<ItemList>((e) => ItemList.fromJson(e as Map<String, dynamic>))
        .toList()
      ..sort((a, b) => a.label.compareTo(b.label));

    return lists;
  }

  FutureOr<List<ItemList>> writeLists(List<ItemList> lists) async {
    final file = await getFile();
    final sortedList = lists..sort((a, b) => a.label.compareTo(b.label));
    file.writeAsStringSync(
      jsonEncode(sortedList),
    );
    return sortedList;
  }

  FutureOr<void> addList(String text) async {
    //state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final newLists = <ItemList>[
        ...state.value!,
        ItemList(label: text, items: [])
      ];
      return await writeLists(newLists);
    });
  }

  FutureOr<void> removeList(ItemList list) async {
    //state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final newLists = state.value!.where((i) {
        return i.label != list.label;
      }).toList();
      return await writeLists(newLists);
    });
  }

  FutureOr<void> addItem(String label, String text) async {
    //state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final newItems = [
        ...state.value!.firstWhere((element) => element.label == label).items,
        Item(label: text, score: 0, ranking: 1200)
      ]..sort((a, b) {
          final rankingDiff = b.ranking.compareTo(a.ranking);
          if (rankingDiff != 0) {
            return rankingDiff;
          }
          return a.label.compareTo(b.label);
        });

      final newLists = [
        ...state.value!.where((element) => element.label != label),
        ItemList(label: label, items: newItems)
      ];

      return await writeLists(newLists);
    });
  }

  Future<void> removeItem(String label, Item item) async {
    //state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final newItems = state.value!
          .firstWhere((element) => element.label == label)
          .items
          .where((i) => i.label != item.label)
          .toList()
        ..sort((a, b) {
          final rankingDiff = b.ranking.compareTo(a.ranking);
          if (rankingDiff != 0) {
            return rankingDiff;
          }
          return a.label.compareTo(b.label);
        });

      final newLists = [
        ...state.value!.where((element) => element.label != label),
        ItemList(label: label, items: newItems)
      ];

      return await writeLists(newLists);
    });
  }

  FutureOr<void> refresh(String label, List<Item> items) async {
    //state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      try {
        final sortedItems = List<Item>.from(items)
          ..sort((a, b) {
            final rankingDiff = b.ranking.compareTo(a.ranking);
            if (rankingDiff != 0) {
              return rankingDiff;
            }
            return a.label.compareTo(b.label);
          });
        final newLists = [
          ...state.value!.where((element) => element.label != label),
          ItemList(
            label: label,
            items: sortedItems,
          )
        ];

        return await writeLists(newLists);
      } catch (e) {
        rethrow;
      }
    });
  }

  FutureOr<void> reload() async {
    // state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await writeLists(state.value!);
    });
  }
}
