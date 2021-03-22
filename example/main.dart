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

  print('\n_________________ List: Deep copy ___________________________');
  print('Should be: [z, a, c, [x, q]]');
  print(list.deepCopy());

  print('\n______________ List: Deep search by value ________________________');
  print('Should be: [z, a, [x]]');
  print(list.deepSearchByValue((value) => ['a', 'z', 'x'].contains(value)));

  print('\n___________________ Set: Deep reverse ____________________________');
  print('Should be: {c, {q, x}, a, z}');
  print(set.deepReverse());

  print('\n____________________ Set: Deep sort ______________________________');
  print('Should be: {a, c, z, {q, x}}');
  print(set.deepSort());

  print('\n_________________ Set: Deep copy ___________________________');
  print('Should be: {z, a, {x, q}, c}');
  print(set.deepCopy());

  print('\n______________ Set: Deep search by value ________________________');
  print('Should be: {z, a, {x}}');
  print(set.deepSearchByValue((value) => ['a', 'z', 'x'].contains(value)));

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

  print('\n_________________ Map: Deep copy ___________________________');
  print('Should be: {z: azz, a: aa, c: cc, y: {x: xx, q: qq}}');
  print(baseMap.deepCopy());

  print('\n_________________ Map: Deep merge ___________________________');
  print('Should be: {z: azz, a: [aa, aa], c: [cc, cc], '
      'y: {x: [xx, xx-diff], q: [qq, qq]}, z-diff: azz}');
  print(baseMap.deepMerge(mapToCompare));
}
