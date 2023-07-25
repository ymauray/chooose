import 'dart:convert';
import 'dart:io';

import 'package:chooose/model/item.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'items_provider.g.dart';

@riverpod
class Items extends _$Items {
  @override
  FutureOr<List<Item>> build() async {
    return readItems();
  }

  FutureOr<File> getFile() async {
    final localPath = await getApplicationDocumentsDirectory();
    final file = File('${localPath.path}/list.txt');
    return file;
  }

  FutureOr<List<Item>> readItems() async {
    final file = await getFile();
    if (!file.existsSync()) {
      return [];
    }
    final content = file.readAsStringSync();
    final items = content
        .split('\n')
        .where((element) => element.isNotEmpty)
        .map(
          (value) => Item.fromJson(jsonDecode(value) as Map<String, dynamic>),
        )
        .toList()
      ..sort((a, b) => b.ranking.compareTo(a.ranking));

    return items;
  }

  FutureOr<void> writeItems(List<Item> items) async {
    final file = await getFile();
    file.writeAsStringSync(
      items.map((item) => jsonEncode(item.toJson())).join('\n'),
    );
  }

  FutureOr<void> addItem(String value) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final items = [
        ...await readItems(),
        Item(
          label: value,
          ranking: 1200,
          score: 0,
        )
      ];
      writeItems(items);
      return await readItems();
    });
  }

  FutureOr<void> removeItem(Item item) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final items = await readItems();
      final newItems = items.where((i) {
        return i.label != item.label;
      }).toList();
      writeItems(newItems);
      return newItems;
    });
  }

  FutureOr<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final items = await readItems();
      return items;
    });
  }
}
