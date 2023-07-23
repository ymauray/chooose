import 'package:chooose/model/item.dart';
import 'package:chooose/model/pair.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sort_state.freezed.dart';

@freezed
class SortState with _$SortState {
  const factory SortState({
    required int step,
    required int steps,
    required List<Pair> pairs,
    required List<Item> items,
  }) = _SortState;
}
