import 'package:deep_collection/deep_collection.dart';

void main() {
  final list = [
    'z',
    'a',
    'c',
    ['x', 'q']
  ];

  final set = {
    'z',
    'a',
    {'x', 'q'},
    'c',
  };

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

  print('\n_________________ List: Deep reverse ___________________________');
  print('Should be: [[q, x], c, a, z]');
  print(list.deepReverse());

  print('\n_________________ List: Deep sort ___________________________');
  print('Should be: [a, c, z, [q, x]]');
  print(list.deepSort());

  print('\n___________________ Set: Deep reverse ____________________________');
  print('Should be: {c, {q, x}, a, z}');
  print(set.deepReverse());

  print('\n____________________ Set: Deep sort ______________________________');
  print('Should be: {a, c, z, {q, x}}');
  print(set.deepSort());

  print('\n________ Map: Deep search by key (key == "q") _______________');
  print('Should be: {y: {q: qq}}');
  print(baseMap.deepSearchByKey((key) => key == 'q'));

  print('\n________ Map: Deep search by value (value == "xx") _______________');
  print('Should be: {y: {x: xx}}');
  print(baseMap.deepSearchByValue((value) => value == 'xx'));

  print('\n_________________ Map: Deep reverse ___________________________');
  print('Should be: {y: {q: qq, x: xx}, c: cc, a: aa, z: azz}');
  print(baseMap.deepReverse());

  print('\n_________________ Map: Deep sort by key __________________________');
  print('Should be: {a: aa, c: cc, y: {q: qq, x: xx}, z: azz}');
  print(baseMap.deepSortByKey());

  print('\n________________ Map: Deep sort by value _________________________');
  print('Should be: {a: aa, z: azz, c: cc, y: {q: qq, x: xx}}');
  print(baseMap.deepSortByValue());

  print('\n_______________ Map: Deep diff by value __________________________');
  print('Should be: {z: azz, y: {x: xx}}');
  print(baseMap.deepDifferenceByValue(mapToCompare));

  print('\n_______________ Map: Deep diff by key __________________________');
  print('Should be: {z: azz}');
  print(baseMap.deepDifferenceByKey(mapToCompare));

  print('\n______________ Map: Deep intersection by value ___________________');
  print('Should be: {a: aa, c: cc, y: {q: qq}}');
  print(baseMap.deepIntersectionByValue(mapToCompare));

  print('\n______________ Map: Deep intersection by key _____________________');
  print('Should be: {a: aa, c: cc, y: {x: xx, q: qq}}');
  print(baseMap.deepIntersectionByKey(mapToCompare));
}
