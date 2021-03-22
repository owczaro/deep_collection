import 'map.dart';
import 'set.dart';

/// Extends [List] in order to add recursion.
extension DeepList<E> on List<E> {
  /// Returns new instance of recursively reversed [List].
  /// It reverses nested [List], [Set] or [Map] (primitive collections),
  /// nested primitive collections inside nested primitive collections
  /// and so on.
  List<E> deepReverse() {
    var result = <E>[];
    for (var i = length - 1; i >= 0; i--) {
      var element;
      element = elementAt(i);
      if (element is Set) {
        element = element.deepReverse();
      } else if (element is List) {
        element = element.deepReverse();
      } else if (element is Map) {
        element = element.deepReverse();
      }

      result.add(element);
    }

    return result;
  }

  /// Returns new instance of [List], which is recursively sorted by values.
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
  List<E> deepSort() {
    var intDoubleValues = <dynamic>[...whereType<int>(), ...whereType<double>()]
      ..sort();
    var stringValues = <String>[...whereType<String>()]..sort();

    var lists = <List>[
      for (var list in whereType<List>()) ...{
        list.deepSort(),
      }
    ]..sort(_sortByLengthRecipe);

    var sets = <Set>[
      for (var set in whereType<Set>()) ...{
        set.deepSort(),
      }
    ]..sort(_sortByLengthRecipe);

    var maps = <Map>[
      for (var map in whereType<Map>()) ...{
        map.deepSortByValue(),
      }
    ]..sort(_sortByLengthRecipe);

    return <E>[
      ...intDoubleValues.cast<E>(),
      ...stringValues.cast<E>(),
      ...lists.cast<E>(),
      ...sets.cast<E>(),
      ...maps.cast<E>(),
    ];
  }

  /// https://stackoverflow.com/questions/64594543/how-to-deep-copy-nested-list-in-dart
  ///
  /// so called shallow copy
  List<E> deepCopy() {
    var newList = [];

    forEach((el) {
      if (el is List) {
        newList.add(el.deepCopy());
      } else if (el is Set) {
        newList.add((el.deepCopy()));
      } else if (el is Map) {
        newList.add((el.deepCopy()));
      } else {
        newList.add(el);
      }
    });

    return newList.cast<E>();
  }

  /// Returns new instance of recursively filtered (by value) [List].
  List deepSearchByValue<V>(bool predicate(V value)) {
    var newList = [];
    forEach((element) {
      if (element is List) {
        var newElement = element.deepSearchByValue<V>(predicate);
        if (newElement.isNotEmpty) {
          newList.add(newElement);
        }
      } else if (element is Set) {
        var newElement = element.deepSearchByValue(predicate);
        if (newElement.isNotEmpty) {
          newList.add(newElement);
        }
      } else if (element is Map) {
        var newElement = element.deepSearchByValue(predicate);
        if (newElement.isNotEmpty) {
          newList.add(newElement);
        }
      } else if (element is V && predicate(element)) {
        newList.add(element);
      }
    });

    return newList;
  }
}

int _sortByLengthRecipe(a, b) => a.length < b.length ? -1 : 1;
