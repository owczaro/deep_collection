import 'list.dart';

/// Extends [Set] in order to add recursion.
extension DeepSet<E> on Set<E> {
  /// Returns new instance of recursively reversed [Set].
  /// It reverses nested [List], [Set] or [Map] (primitive collections),
  /// nested primitive collections inside nested primitive collections
  /// and so on.
  Set<E> deepReverse() =>
      toList(growable: false).deepReverse().toSet().cast<E>();

  /// Returns new instance of [Set], which is recursively sorted by values.
  /// It sorts by values nested [List], [Set] or [Map] (primitive collections),
  /// nested primitive collections inside nested primitive collections
  /// and so on.
  ///
  /// it gets rid of incomparable values like:
  /// * [bool]
  /// * `null`
  ///
  /// If there are more [List], [Set] or [Map], it groups them, sorts by length
  /// and puts in the following order:
  /// 1. [int] and [double] values
  /// 2. [String] values
  /// 3. All [List] sorted by length
  /// 4. All [Set] sorted by length
  /// 5. All [Map] sorted by length
  Set<E> deepSort() => toList(growable: false).deepSort().toSet().cast<E>();

  /// https://stackoverflow.com/questions/64594543/how-to-deep-copy-nested-list-in-dart
  ///
  /// so called shallow copy
  Set<E> deepCopy() => toList(growable: false).deepCopy().toSet().cast<E>();

  /// Returns new instance of recursively filtered (by value) [Set].
  Set deepSearchByValue<V>(bool predicate(V value)) =>
      toList(growable: false).deepSearchByValue<V>(predicate).toSet().cast<E>();
}
