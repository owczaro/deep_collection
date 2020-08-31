import 'package:deep_collection/deep_map.dart';

void main() {
  final baseMap = {
    'z': 'azz',
    'a': 'aa',
    'c': 'cc',
    'y': {'x': 'xx', 'q': 'qq'}
  };
  final mapToCompare = {
    'z-diff': 'azz',
    'a': 'aa',
    'c': 'cc',
    'y': {'x': 'xx-diff', 'q': 'qq'}
  };

  print('\n_________________ Deep reverse ___________________________');
  print('Should be: {y: {q: qq, x: xx}, c: cc, a: aa, z: azz}');
  print(baseMap.deepReverse());

  print('\n_________________ Deep sort by key ___________________________');
  print('Should be: {a: aa, c: cc, y: {q: qq, x: xx}, z: azz}');
  print(baseMap.deepSortByKey());

  print('\n_________________ Deep sort by value ___________________________');
  print('Should be: {a: aa, z: azz, c: cc, y: {q: qq, x: xx}}');
  print(baseMap.deepSortByValue());

  print('\n_________________ Deep diff ___________________________');
  print('Should be: {z: azz, y: {x: xx}}');
  print(baseMap.deepDifference(mapToCompare));

  print('\n________________ Deep intersection ______________________');
  print('Should be: {a: aa, c: cc, y: {q: qq}}');
  print(baseMap.deepIntersection(mapToCompare));
}
