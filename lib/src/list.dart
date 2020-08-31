import 'map.dart';
import 'set.dart';

/// Extends [List] in order to add recursion.
extension DeepList<E> on List<E> {
  /// Returns new instance of recursively reversed [List].
  /// It reverses nested [List], [Set] or [Map] (primitive collections),
  /// nested primitive collections inside nested primitive collections
  /// and so on.
  List<E> deepReverse<E>() {
    var result = <E>[];
    for (var i in List.generate(length, (index) => index++).reversed) {
      var element;
      element = elementAt(i);
      if (element is Set) {
        element = (element as Set).deepReverse();
      } else if (element is List) {
        element = (element as List).deepReverse();
      } else if (element is Map) {
        element = (element as Map).deepReverse();
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
  List<E> deepSort<E>() {
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
}

int _sortByLengthRecipe(a, b) => a.length < b.length ? -1 : 1;
