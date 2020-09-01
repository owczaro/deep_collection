import 'dart:collection';

import 'list.dart';
import 'set.dart';

/// Extends [Map] in order to add recursion.
extension DeepMap<K, V> on Map<K, V> {
  /// Returns new instance of recursively filtered (by key) [Map].
  /// Does not work with nested [List] and [Set] yet.
  Map deepSearchByKey(bool predicate(dynamic key)) =>
      LinkedHashMap.fromIterable(keys,
          key: (k) => k,
          value: (k) {
            if (this[k] is Map) {
              return (this[k] as Map).deepSearchByKey(predicate);
            } else if (predicate(k)) {
              return this[k];
            }
          })
        ..removeWhere(
            (key, value) => value == null || (value is Map && value.isEmpty));

  /// Returns new instance of recursively filtered (by value) [Map].
  /// Does not work with nested [List] and [Set] yet.
  Map deepSearchByValue(bool predicate(V value)) =>
      LinkedHashMap.fromIterable(keys,
          key: (k) => k,
          value: (k) {
            if (this[k] is Map) {
              return (this[k] as Map).deepSearchByValue(predicate);
            } else if (predicate(this[k])) {
              return this[k];
            }
          })
        ..removeWhere(
            (key, value) => value == null || (value is Map && value.isEmpty));

  /// Returns new instance of recursively reversed [Map].
  /// It reverses nested [List], [Set] or [Map] (primitive collections),
  /// nested primitive collections inside nested primitive collections
  /// and so on.
  Map<K, V> deepReverse() {
    final reversedKeys = keys.toList(growable: false).deepReverse();
    var reversedMap = LinkedHashMap.fromIterable(<K>[...reversedKeys],
        key: (k) => k,
        value: (k) {
          if (this[k] is Map) {
            return (this[k] as Map).deepReverse();
          } else if (this[k] is Set) {
            return (this[k] as Set).deepReverse();
          } else if (this[k] is List) {
            return (this[k] as List).deepReverse();
          } else {
            return this[k];
          }
        });

    return reversedMap.cast<K, V>();
  }

  /// Returns new instance of [Map], which is recursively sorted by keys.
  /// It sorts by keys even [Map] nested as a value,
  /// nested [Map] inside nested [Map] and so on.
  ///
  /// It does not sort nested [List] or [Set], because keys
  /// are sorted by default in those types.
  ///
  /// it gets rid of incomparable keys (and associated values) like:
  /// * [bool]
  /// * `null`
  ///
  /// Sort order:
  /// 1. [int] and [double] keys
  /// 2. [String] keys
  Map<K, V> deepSortByKey() => LinkedHashMap.fromIterable(
      <dynamic>[...keys.toList(growable: false).deepSort()],
      key: (k) => k,
      value: (k) {
        if (this[k] is Map) {
          return (this[k] as Map).deepSortByKey();
        } else if (this[k] is Set) {
          return _deepSortByKeyInSet(this[k] as Set);
        } else if (this[k] is List) {
          return _deepSortByKeyInList(this[k] as List);
        } else {
          return this[k];
        }
      }).cast<K, V>();

  /// Returns new instance of [Map], which is recursively sorted by values.
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
  Map<K, V> deepSortByValue() {
    var intAndDoubleValues = Map<dynamic, dynamic>.fromEntries(entries
        .where((element) => element?.value is int || element?.value is double));

    var sortedKeysFromIntAndDoubleValues = intAndDoubleValues.keys.toList(
        growable: false)
      ..sort((a, b) => intAndDoubleValues[a].compareTo(intAndDoubleValues[b]));
    var sortedIntAndDoubleValues = LinkedHashMap.fromIterable(
        sortedKeysFromIntAndDoubleValues,
        key: (k) => k,
        value: (k) => intAndDoubleValues[k]);

    var stringValues = Map<dynamic, dynamic>.fromEntries(
        entries.where((element) => element?.value is String));
    var sortedKeysFromStringValues = stringValues.keys.toList(growable: false)
      ..sort((a, b) => stringValues[a].compareTo(stringValues[b]));
    var sortedStringValues = LinkedHashMap.fromIterable(
        sortedKeysFromStringValues,
        key: (k) => k,
        value: (k) => stringValues[k]);

    var listValues = Map<dynamic, dynamic>.fromEntries(
        entries.where((element) => element?.value is List));
    listValues.forEach((key, value) {
      listValues[key] = (value as List).deepSort();
    });
    var sortedKeysFromListValues = listValues.keys.toList(growable: false)
      ..sort((a, b) =>
          (listValues[a] as List).length < (listValues[b] as List).length
              ? -1
              : 1);
    var sortedListValues = LinkedHashMap.fromIterable(sortedKeysFromListValues,
        key: (k) => k, value: (k) => listValues[k]);

    var setValues = Map<dynamic, dynamic>.fromEntries(
        entries.where((element) => element?.value is Set));
    setValues.forEach((key, value) {
      setValues[key] = (value as Set).deepSort();
    });
    var sortedKeysFromSetValues = setValues.keys.toList(growable: false)
      ..sort((a, b) =>
          (setValues[a] as Set).length < (setValues[b] as Set).length ? -1 : 1);
    var sortedSetValues = LinkedHashMap.fromIterable(sortedKeysFromSetValues,
        key: (k) => k, value: (k) => setValues[k]);

    var mapValues = Map<dynamic, dynamic>.fromEntries(
        entries.where((element) => element?.value is Map));
    mapValues.forEach((key, value) {
      mapValues[key] = (value as Map).deepSortByValue();
    });
    var sortedKeysFromMapValues = mapValues.keys.toList(growable: false)
      ..sort((a, b) =>
          (mapValues[a] as Map).length < (mapValues[b] as Map).length ? -1 : 1);
    var sortedMapValues = LinkedHashMap.fromIterable(sortedKeysFromMapValues,
        key: (k) => k, value: (k) => mapValues[k]);

    return <K, V>{
      ...sortedIntAndDoubleValues.cast<K, V>(),
      ...sortedStringValues.cast<K, V>(),
      ...sortedListValues.cast<K, V>(),
      ...sortedSetValues.cast<K, V>(),
      ...sortedMapValues.cast<K, V>(),
    };
  }

  /// Returns new instance of [Map]
  /// containing values, which differs in [toCompare].
  /// Does not work with nested [List] and [Set] yet.
  ///
  /// According to complement in set theory (for clarity see Venn Diagrams):
  /// A - [this]
  /// B - [toCompare]
  /// Difference in values (relative complement): A \ B
  Map deepDifferenceByValue(Map toCompare) {
    var diff = {};
    forEach((key, value) {
      if (!toCompare.containsKey(key)) {
        diff.addEntries([MapEntry(key, value)]);
      } else if (value is Map && toCompare[key] is Map) {
        var deepDiff = value.deepDifferenceByValue(toCompare[key]);
        if (deepDiff.isNotEmpty) {
          diff.addEntries([MapEntry(key, deepDiff)]);
        }
      } else if (value?.runtimeType != toCompare[key]?.runtimeType ||
          value != toCompare[key]) {
        diff.addEntries([MapEntry(key, value)]);
      }
    });

    return diff;
  }

  /// Returns new instance of [Map]
  /// containing values, which key differs in [toCompare].
  /// Does not work with nested [List] and [Set] yet.
  ///
  /// According to complement in set theory (for clarity see Venn Diagrams):
  /// A - [this]
  /// B - [toCompare]
  /// Difference in keys (relative complement): A \ B
  Map deepDifferenceByKey(Map toCompare) {
    var diff = {};
    forEach((key, value) {
      if (!toCompare.containsKey(key)) {
        diff.addEntries([MapEntry(key, value)]);
      } else if (value is Map && toCompare[key] is Map) {
        var deepDiff = value.deepDifferenceByKey(toCompare[key]);
        if (deepDiff.isNotEmpty) {
          diff.addEntries([MapEntry(key, deepDiff)]);
        }
      } else if (value is Map) {
        diff.addEntries([MapEntry(key, value)]);
      }
    });

    return diff;
  }

  /// Returns new instance of [Map]
  /// containing all values existing in both maps.
  /// Does not work with nested [List] and [Set] yet.
  ///
  /// According to complement in set theory (for clarity see Venn Diagrams):
  /// A - [this]
  /// B - [toCompare]
  /// Intersection in values: A ⋂ B
  Map deepIntersectionByValue(Map toCompare) {
    var intersection = {};
    forEach((key, value) {
      if (toCompare.containsKey(key)) {
        if (value is Map && toCompare[key] is Map) {
          var deepIntersection = value.deepIntersectionByValue(toCompare[key]);
          if (deepIntersection.isNotEmpty) {
            intersection.addEntries([MapEntry(key, deepIntersection)]);
          }
        } else if (value?.runtimeType == toCompare[key]?.runtimeType &&
            value == toCompare[key]) {
          intersection.addEntries([MapEntry(key, value)]);
        }
      }
    });

    return intersection;
  }

  /// Returns new instance of [Map]
  /// containing all values, which key exists in both maps.
  /// Does not work with nested [List] and [Set] yet.
  ///
  /// According to complement in set theory (for clarity see Venn Diagrams):
  /// A - [this]
  /// B - [toCompare]
  /// Intersection in keys: A ⋂ B
  Map deepIntersectionByKey(Map toCompare) {
    var intersection = {};
    forEach((key, value) {
      if (toCompare.containsKey(key)) {
        if (value is Map && toCompare[key] is Map) {
          var deepIntersection = value.deepIntersectionByKey(toCompare[key]);
          if (deepIntersection.isNotEmpty) {
            intersection.addEntries([MapEntry(key, deepIntersection)]);
          }
        } else if (value is Map && toCompare[key] is! Map) {
          intersection.addEntries([MapEntry(key, {})]);
        } else {
          intersection.addEntries([MapEntry(key, value)]);
        }
      }
    });

    return intersection;
  }
}

/// Returns new instance of deeply sorted (by keys) [Set].
/// In fact this is a port to iterate throw a set inside a map
/// and sort nested maps.
Set<E> _deepSortByKeyInSet<E>(Set<E> set) {
  var values = <dynamic>{};
  for (var value in set) {
    if (value is Map) {
      values.add(value.deepSortByKey());
    } else if (value is List) {
      values.add(_deepSortByKeyInList(value));
    } else if (value is Set) {
      values.add(_deepSortByKeyInSet(value));
    } else {
      values.add(value);
    }
  }

  return values.cast<E>();
}

/// Returns new instance of deeply sorted (by keys) [List].
/// In fact this is a port to iterate throw a list inside a map
/// and sort nested maps.
List<E> _deepSortByKeyInList<E>(List<E> list) {
  var values = <dynamic>[];
  for (var value in list) {
    if (value is Map) {
      values.add(value.deepSortByKey());
    } else if (value is List) {
      values.add(_deepSortByKeyInList(value));
    } else if (value is Set) {
      values.add(_deepSortByKeyInSet(value));
    } else {
      values.add(value);
    }
  }

  return values.cast<E>();
}
