// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sort_state_notifier_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sortStateNotifierHash() => r'742c0458ebb37dcf46b3baa9e1d1382d9359c059';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$SortStateNotifier
    extends BuildlessAutoDisposeNotifier<SortState> {
  late final String label;
  late final List<Item> items;

  SortState build(
    String label,
    List<Item> items,
  );
}

/// See also [SortStateNotifier].
@ProviderFor(SortStateNotifier)
const sortStateNotifierProvider = SortStateNotifierFamily();

/// See also [SortStateNotifier].
class SortStateNotifierFamily extends Family<SortState> {
  /// See also [SortStateNotifier].
  const SortStateNotifierFamily();

  /// See also [SortStateNotifier].
  SortStateNotifierProvider call(
    String label,
    List<Item> items,
  ) {
    return SortStateNotifierProvider(
      label,
      items,
    );
  }

  @override
  SortStateNotifierProvider getProviderOverride(
    covariant SortStateNotifierProvider provider,
  ) {
    return call(
      provider.label,
      provider.items,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'sortStateNotifierProvider';
}

/// See also [SortStateNotifier].
class SortStateNotifierProvider
    extends AutoDisposeNotifierProviderImpl<SortStateNotifier, SortState> {
  /// See also [SortStateNotifier].
  SortStateNotifierProvider(
    this.label,
    this.items,
  ) : super.internal(
          () => SortStateNotifier()
            ..label = label
            ..items = items,
          from: sortStateNotifierProvider,
          name: r'sortStateNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sortStateNotifierHash,
          dependencies: SortStateNotifierFamily._dependencies,
          allTransitiveDependencies:
              SortStateNotifierFamily._allTransitiveDependencies,
        );

  final String label;
  final List<Item> items;

  @override
  bool operator ==(Object other) {
    return other is SortStateNotifierProvider &&
        other.label == label &&
        other.items == items;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, label.hashCode);
    hash = _SystemHash.combine(hash, items.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  SortState runNotifierBuild(
    covariant SortStateNotifier notifier,
  ) {
    return notifier.build(
      label,
      items,
    );
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
