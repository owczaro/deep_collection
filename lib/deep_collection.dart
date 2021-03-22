/// Extends [List] in order to run recursive operations, such as:
/// * deeply sort (by values)
/// * deeply reverse (by values)
/// * deeply copy (by values)
/// * deeply search (by values)
///
/// Extends [Set] in order to run recursive operations, such as:
/// * deeply sort (by values)
/// * deeply reverse (by values)
/// * deeply copy (by values)
/// * deeply search (by values)
///
/// Extends `Map` in order to run recursive operations, such as:
/// * deeply search (by keys) - doesn't accept nested [List] or [Set]
/// * deeply search (by values)
/// * deeply sort (by keys or values)
/// * deeply reverse
/// * deeply find intersections (by keys and values) - does not accept
/// nested [List] or [Set]
/// * deeply find differences (by keys and values) - does not accept
/// nested [List] or [Set]
/// * deeply merge (by keys)
/// * deeply copy (by values)
library deep_collection;

export 'src/list.dart';
export 'src/map.dart';
export 'src/set.dart';
