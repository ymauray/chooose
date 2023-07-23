// ignore_for_file: avoid_final_parameters

import 'package:freezed_annotation/freezed_annotation.dart';

part 'item.freezed.dart';
part 'item.g.dart';

@unfreezed
class Item with _$Item {
  factory Item({
    required final String label,
    required int ranking,
    required int score,
  }) = _Item;

  factory Item.fromJson(Map<String, Object?> json) => _$ItemFromJson(json);
}
