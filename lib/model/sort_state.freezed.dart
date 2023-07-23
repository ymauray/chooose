// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sort_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SortState {
  int get step => throw _privateConstructorUsedError;
  int get steps => throw _privateConstructorUsedError;
  List<Pair> get pairs => throw _privateConstructorUsedError;
  List<Item> get items => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SortStateCopyWith<SortState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SortStateCopyWith<$Res> {
  factory $SortStateCopyWith(SortState value, $Res Function(SortState) then) =
      _$SortStateCopyWithImpl<$Res, SortState>;
  @useResult
  $Res call({int step, int steps, List<Pair> pairs, List<Item> items});
}

/// @nodoc
class _$SortStateCopyWithImpl<$Res, $Val extends SortState>
    implements $SortStateCopyWith<$Res> {
  _$SortStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? step = null,
    Object? steps = null,
    Object? pairs = null,
    Object? items = null,
  }) {
    return _then(_value.copyWith(
      step: null == step
          ? _value.step
          : step // ignore: cast_nullable_to_non_nullable
              as int,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as int,
      pairs: null == pairs
          ? _value.pairs
          : pairs // ignore: cast_nullable_to_non_nullable
              as List<Pair>,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Item>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SortStateCopyWith<$Res> implements $SortStateCopyWith<$Res> {
  factory _$$_SortStateCopyWith(
          _$_SortState value, $Res Function(_$_SortState) then) =
      __$$_SortStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int step, int steps, List<Pair> pairs, List<Item> items});
}

/// @nodoc
class __$$_SortStateCopyWithImpl<$Res>
    extends _$SortStateCopyWithImpl<$Res, _$_SortState>
    implements _$$_SortStateCopyWith<$Res> {
  __$$_SortStateCopyWithImpl(
      _$_SortState _value, $Res Function(_$_SortState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? step = null,
    Object? steps = null,
    Object? pairs = null,
    Object? items = null,
  }) {
    return _then(_$_SortState(
      step: null == step
          ? _value.step
          : step // ignore: cast_nullable_to_non_nullable
              as int,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as int,
      pairs: null == pairs
          ? _value._pairs
          : pairs // ignore: cast_nullable_to_non_nullable
              as List<Pair>,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Item>,
    ));
  }
}

/// @nodoc

class _$_SortState implements _SortState {
  const _$_SortState(
      {required this.step,
      required this.steps,
      required final List<Pair> pairs,
      required final List<Item> items})
      : _pairs = pairs,
        _items = items;

  @override
  final int step;
  @override
  final int steps;
  final List<Pair> _pairs;
  @override
  List<Pair> get pairs {
    if (_pairs is EqualUnmodifiableListView) return _pairs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pairs);
  }

  final List<Item> _items;
  @override
  List<Item> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'SortState(step: $step, steps: $steps, pairs: $pairs, items: $items)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SortState &&
            (identical(other.step, step) || other.step == step) &&
            (identical(other.steps, steps) || other.steps == steps) &&
            const DeepCollectionEquality().equals(other._pairs, _pairs) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      step,
      steps,
      const DeepCollectionEquality().hash(_pairs),
      const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SortStateCopyWith<_$_SortState> get copyWith =>
      __$$_SortStateCopyWithImpl<_$_SortState>(this, _$identity);
}

abstract class _SortState implements SortState {
  const factory _SortState(
      {required final int step,
      required final int steps,
      required final List<Pair> pairs,
      required final List<Item> items}) = _$_SortState;

  @override
  int get step;
  @override
  int get steps;
  @override
  List<Pair> get pairs;
  @override
  List<Item> get items;
  @override
  @JsonKey(ignore: true)
  _$$_SortStateCopyWith<_$_SortState> get copyWith =>
      throw _privateConstructorUsedError;
}
