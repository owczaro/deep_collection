/// Extends [Map] in order to run recursive operations, such as:
/// * deeply sort (by keys or values)
/// * deeply reverse
/// * deeply find intersections (by values) - does not accept
/// nested [List] or [Set]
/// * deeply find differences (by values) - does not accept
/// nested [List] or [Set]
library deep_map;

export 'src/map.dart';
