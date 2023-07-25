// ignore_for_file: avoid_final_parameters

import 'package:chooose/model/item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_list.freezed.dart';
part 'item_list.g.dart';

@unfreezed
class ItemList with _$ItemList {
  factory ItemList({
    required final String label,
    required final List<Item> items,
  }) = _ItemList;

  factory ItemList.fromJson(Map<String, Object?> json) =>
      _$ItemListFromJson(json);
}
