import 'package:deep_collection/deep_collection.dart';
import 'package:test/test.dart';

void main() {
  group('Map - deepSearchByKey()', () {
    test('Simple map - strings', () {
      final map = {'a': 'a', 'c': 'c', 'b': 'b'};
      final filteredMap = map.deepSearchByKey((key) => key == 'c');

      expect(filteredMap.values, orderedEquals(['c']));
      expect(filteredMap.keys, orderedEquals(['c']));
    });

    test('Simple map - strings - no match', () {
      final map = {'a': 'a', 'c': 'c', 'b': 'b'};
      final filteredMap = map.deepSearchByKey((key) => key == 'no-key');

      expect(filteredMap, hasLength(0));
    });

    test('Simple map - integers', () {
      final map = {1: 1, 3: 3, 2: 2};
      final filteredMap = map.deepSearchByKey((key) => key == 3);

      expect(filteredMap.values, orderedEquals([3]));
      expect(filteredMap.keys, orderedEquals([3]));
    });

    test('Simple map - double', () {
      final map = {1.3: 1.3, 3.2: 3.2, 2.1: 2.1};
      final filteredMap = map.deepSearchByKey((key) => key == 3.2);

      expect(filteredMap.values, orderedEquals([3.2]));
      expect(filteredMap.keys, orderedEquals([3.2]));
    });

    test('Simple map - bool', () {
      final map = {
        1.3: 1.3,
        3.2: 3.2,
        2.1: 2.1,
        true: true,
        false: false,
      };
      final filteredMap = map.deepSearchByKey((key) => key == false);

      expect(filteredMap.values, orderedEquals([false]));
      expect(filteredMap.keys, orderedEquals([false]));
    });

    test('Simple map - various types: strings, doubles & integers', () {
      final map = {
        1.3: 1.3,
        'b': 'b',
        3.2: 3.2,
        2: 2,
        1: 1,
        'a': 'a',
        'c': 'c',
        3: 3,
        2.1: 2.1,
      };
      final filteredMap =
          map.deepSearchByKey((key) => key != 'b' && key != 3.2 && key != '1');

      expect(
          filteredMap.values, unorderedEquals([1.3, 2, 1, 'a', 'c', 3, 2.1]));
      expect(filteredMap.keys, unorderedEquals([1.3, 2, 1, 'a', 'c', 3, 2.1]));
    });

    test('Nested map - match in sublist', () {
      final map = {
        'c': 'c',
        'a': {'x': 'c', 'z': 'b', 'q': 'a'},
        'b': 'b'
      };
      final filteredMap = map.deepSearchByKey((key) => key == 'q');

      expect(filteredMap.keys, orderedEquals(['a']));
      expect(filteredMap['a'], isMap);
      expect((filteredMap['a'] as Map).values, orderedEquals(['a']));
      expect((filteredMap['a'] as Map).keys, orderedEquals(['q']));
    });

    test('Nested map - match in main list and sublist', () {
      final map = {
        'c': 'c',
        'a': {'x': 'c', 'z': 'b', 'b': 'z', 'q': 'a'},
        'b': 'b'
      };
      final filteredMap = map.deepSearchByKey((key) => key == 'b');

      expect(filteredMap.keys, orderedEquals(['a', 'b']));
      expect(filteredMap['b'], equals('b'));
      expect(filteredMap['a'], isMap);
      expect((filteredMap['a'] as Map).values, orderedEquals(['z']));
      expect((filteredMap['a'] as Map).keys, orderedEquals(['b']));
    });
  });

  // ###########################################################################

  group('Map - deepSearchByValue()', () {
    test('Simple map - strings', () {
      final map = {'a': 'a', 'c': 'c', 'b': 'b'};
      final filteredMap = map.deepSearchByValue((value) => value == 'c');

      expect(filteredMap.values, orderedEquals(['c']));
      expect(filteredMap.keys, orderedEquals(['c']));
    });

    test('Simple map - strings - no match', () {
      final map = {'a': 'a', 'c': 'c', 'b': 'b'};
      final filteredMap = map.deepSearchByValue((value) => value == 'no-val');

      expect(filteredMap, hasLength(0));
    });

    test('Simple map - integers', () {
      final map = {1: 1, 3: 3, 2: 2};
      final filteredMap = map.deepSearchByValue((value) => value == 3);

      expect(filteredMap.values, orderedEquals([3]));
      expect(filteredMap.keys, orderedEquals([3]));
    });

    test('Simple map - double', () {
      final map = {1.3: 1.3, 3.2: 3.2, 2.1: 2.1};
      final filteredMap = map.deepSearchByValue((value) => value == 3.2);

      expect(filteredMap.values, orderedEquals([3.2]));
      expect(filteredMap.keys, orderedEquals([3.2]));
    });

    test('Simple map - bool', () {
      final map = {
        1.3: 1.3,
        3.2: 3.2,
        2.1: 2.1,
        true: true,
        false: false,
      };
      final filteredMap = map.deepSearchByValue((value) => value == false);

      expect(filteredMap.values, orderedEquals([false]));
      expect(filteredMap.keys, orderedEquals([false]));
    });

    test('Simple map - various types: strings, doubles & integers', () {
      final map = {
        1.3: 1.3,
        'b': 'b',
        3.2: 3.2,
        2: 2,
        1: 1,
        'a': 'a',
        'c': 'c',
        3: 3,
        2.1: 2.1,
      };
      final filteredMap = map.deepSearchByValue(
          (value) => value != 'b' && value != 3.2 && value != '1');

      expect(
          filteredMap.values, unorderedEquals([1.3, 2, 1, 'a', 'c', 3, 2.1]));
      expect(filteredMap.keys, unorderedEquals([1.3, 2, 1, 'a', 'c', 3, 2.1]));
    });

    test('Nested map - match in sublist', () {
      final map = {
        'c': 'c',
        'a': {'x': 'c', 'z': 'b', 'q': 'a'},
        'b': 'b'
      };
      final filteredMap = map.deepSearchByValue((value) => value == 'a');

      expect(filteredMap.keys, orderedEquals(['a']));
      expect(filteredMap['a'], isMap);
      expect((filteredMap['a'] as Map).values, orderedEquals(['a']));
      expect((filteredMap['a'] as Map).keys, orderedEquals(['q']));
    });

    test('Nested map - match in main list and sublist', () {
      final map = {
        'c': 'c',
        'a': {'x': 'c', 'z': 'b', 'q': 'a'},
        'b': 'b'
      };
      final filteredMap = map.deepSearchByValue((value) => value == 'b');

      expect(filteredMap.keys, orderedEquals(['a', 'b']));
      expect(filteredMap['b'], equals('b'));
      expect(filteredMap['a'], isMap);
      expect((filteredMap['a'] as Map).values, orderedEquals(['b']));
      expect((filteredMap['a'] as Map).keys, orderedEquals(['z']));
    });
  });

  // ###########################################################################

  group('Map - deepReverse()', () {
    test('Simple map - strings', () {
      final map = {'a': 'aa', 'c': 'cc', 'b': 'bb'};
      final reversedMap = map.deepReverse();
      expect(reversedMap, hasLength(map.length));
      expect(reversedMap.keys, orderedEquals(['b', 'c', 'a']));
    });

    test('Simple map - integers', () {
      final map = {1: 1, 3: 3, 2: 2};
      final reversedMap = map.deepReverse();

      expect(reversedMap, hasLength(map.length));
      expect(reversedMap.keys, orderedEquals([2, 3, 1]));
    });

    test('Simple map - double', () {
      final map = {1.3: 1.3, 3.2: 3.2, 2.1: 2.1};
      final reversedMap = map.deepReverse();

      expect(reversedMap, hasLength(map.length));
      expect(reversedMap.keys, orderedEquals([2.1, 3.2, 1.3]));
    });

    test(
        'Simple map - various types: '
        'strings, doubles, bool, null & integers', () {
      final map = {
        null: null,
        true: true,
        false: false,
        1.3: 1.3,
        'b': 'b',
        3.2: 3.2,
        2: 2,
        1: 1,
        'a': 'a',
        'c': 'c',
        3: 3,
        2.1: 2.1,
      };
      final reversedMap = map.deepReverse();

      expect(reversedMap, hasLength(map.length));
      expect(
          reversedMap.keys,
          orderedEquals(
              [2.1, 3, 'c', 'a', 1, 2, 3.2, 'b', 1.3, false, true, null]));
    });

    test('Nested List', () {
      final map = {
        'c': 'cc',
        'a': ['q', 's'],
        'b': 'bb'
      };
      final reversedMap = map.deepReverse();

      expect(reversedMap, hasLength(map.length));
      expect(reversedMap.keys, orderedEquals(['b', 'a', 'c']));
      expect(reversedMap['a'], isList);
      expect(reversedMap['a'], orderedEquals(['s', 'q']));
    });

    test('Nested Set', () {
      final map = {
        'c': 'cc',
        'a': {'q', 's'},
        'b': 'bb'
      };
      final reversedMap = map.deepReverse();

      expect(reversedMap, hasLength(map.length));
      expect(reversedMap.keys, orderedEquals(['b', 'a', 'c']));
      expect(reversedMap['a'], isA<Set>());
      expect(reversedMap['a'], orderedEquals(['s', 'q']));
    });

    test('Nested Map', () {
      final map = {
        'c': 'cc',
        'a': {'q': 'qq', 's': 'ss'},
        'b': 'bb'
      };
      final reversedMap = map.deepReverse();
      expect(reversedMap, hasLength(map.length));
      expect(reversedMap.keys, orderedEquals(['b', 'a', 'c']));
      expect(reversedMap['a'], isMap);
      expect((reversedMap['a'] as Map).keys, orderedEquals(['s', 'q']));
    });
  });
  // ###########################################################################

  group('Map - deepSortByKey()', () {
    test('Simple map - strings', () {
      final map = {'a': 'aa', 'c': 'cc', 'b': 'bb'};
      final sortedMap = map.deepSortByKey();

      expect(sortedMap, hasLength(map.length));
      expect(sortedMap.keys, orderedEquals(['a', 'b', 'c']));
    });

    test('Simple map - integers', () {
      final map = {1: 1, 3: 3, 2: 2};
      final sortedMap = map.deepSortByKey();

      expect(sortedMap, hasLength(map.length));
      expect(sortedMap.keys, orderedEquals([1, 2, 3]));
    });

    test('Simple map - double', () {
      final map = {1.3: 1.3, 3.2: 3.2, 2.1: 2.1};
      final sortedMap = map.deepSortByKey();

      expect(sortedMap, hasLength(map.length));
      expect(sortedMap.keys, orderedEquals([1.3, 2.1, 3.2]));
    });

    test('Simple map - excluding bool & null', () {
      final map = {
        1.3: 1.3,
        3.2: 3.2,
        2.1: 2.1,
        null: null,
        true: true,
        false: false,
      };
      final sortedMap = map.deepSortByKey();

      expect(sortedMap, hasLength(map.length - 3));
      expect(sortedMap.keys, orderedEquals([1.3, 2.1, 3.2]));
    });

    test('Simple map - various types: strings, doubles & integers', () {
      final map = {
        1.3: 1.3,
        'b': 'b',
        3.2: 3.2,
        2: 2,
        1: 1,
        'a': 'a',
        'c': 'c',
        3: 3,
        2.1: 2.1,
      };
      final sortedMap = map.deepSortByKey();

      expect(sortedMap, hasLength(map.length));
      expect(sortedMap.keys,
          orderedEquals([1, 1.3, 2, 2.1, 3, 3.2, 'a', 'b', 'c']));
    });

    test('Nested List', () {
      final map = {
        'c': 'c',
        'a': ['x', 'a', 'd'],
        'b': 'b'
      };
      final sortedMap = map.deepSortByKey();

      expect(sortedMap, hasLength(map.length));
      expect(sortedMap.keys, orderedEquals(['a', 'b', 'c']));
      expect(sortedMap['a'], isList);
      expect(sortedMap['a'], orderedEquals(['x', 'a', 'd']));
    });

    test('Nested Set', () {
      final map = {
        'c': 'c',
        'a': {'x', 'a', 'd'},
        'b': 'b'
      };
      final sortedMap = map.deepSortByKey();

      expect(sortedMap, hasLength(map.length));
      expect(sortedMap.keys, orderedEquals(['a', 'b', 'c']));
      expect(sortedMap['a'], isA<Set>());
      expect(sortedMap['a'], orderedEquals(['x', 'a', 'd']));
    });

    test('Nested map', () {
      final map = {
        'c': 'c',
        'a': {'x': 'c', 'z': 'b', 'q': 'a'},
        'b': 'b'
      };
      final sortedMap = map.deepSortByKey();

      expect(sortedMap['a'], isMap);
      expect((sortedMap['a'] as Map).keys, orderedEquals(['q', 'x', 'z']));
    });

    test('Type order', () {
      final map = {
        'a': 'a',
        2.2: 2.2,
        2: 2,
        'b': 'b',
        1.1: 1.1,
        1: 1,
      };
      final sortedMap = map.deepSortByKey();

      expect(sortedMap, hasLength(map.length));
      expect(sortedMap.keys.elementAt(0), isA<int>());
      expect(sortedMap.keys.elementAt(1), isA<double>());
      expect(sortedMap.keys.elementAt(2), isA<int>());
      expect(sortedMap.keys.elementAt(3), isA<double>());
      expect(sortedMap.keys.elementAt(4), isA<String>());
      expect(sortedMap.keys.elementAt(5), isA<String>());
    });
  });

  // ###########################################################################

  group('Map - deepSortByValue()', () {
    test('Simple map - strings', () {
      final map = {'a': 'a', 'c': 'c', 'b': 'b'};
      final sortedMap = map.deepSortByValue();

      expect(sortedMap.values, orderedEquals(['a', 'b', 'c']));
    });

    test('Simple map - integers', () {
      final map = {1: 1, 3: 3, 2: 2};
      final sortedMap = map.deepSortByValue();

      expect(sortedMap.keys, orderedEquals([1, 2, 3]));
    });

    test('Simple map - double', () {
      final map = {1.3: 1.3, 3.2: 3.2, 2.1: 2.1};
      final sortedMap = map.deepSortByValue();

      expect(sortedMap.keys, orderedEquals([1.3, 2.1, 3.2]));
    });

    test('Simple map - excluding bool & null', () {
      final map = {
        1.3: 1.3,
        3.2: 3.2,
        2.1: 2.1,
        null: null,
        true: true,
        false: false,
      };
      final sortedMap = map.deepSortByValue();

      expect(sortedMap, hasLength(map.length - 3));
      expect(sortedMap.values, orderedEquals([1.3, 2.1, 3.2]));
    });

    test('Simple map - various types: strings, doubles & integers', () {
      final map = {
        1.3: 1.3,
        'b': 'b',
        3.2: 3.2,
        2: 2,
        1: 1,
        'a': 'a',
        'c': 'c',
        3: 3,
        2.1: 2.1,
      };
      final sortedMap = map.deepSortByValue();

      expect(sortedMap.keys,
          orderedEquals([1, 1.3, 2, 2.1, 3, 3.2, 'a', 'b', 'c']));
    });

    test('Nested List', () {
      final map = {
        'c': 'c',
        'a': ['x', 'a', 'd'],
        'b': 'b'
      };
      final sortedMap = map.deepSortByValue();

      expect(sortedMap.keys, orderedEquals(['b', 'c', 'a']));
      expect(sortedMap['a'], isList);
      expect(sortedMap['a'], orderedEquals(['a', 'd', 'x']));
    });

    test('Nested set', () {
      final map = {
        'c': 'c',
        'a': {'x', 'z', 'q'},
        'b': 'b'
      };
      final sortedMap = map.deepSortByValue();

      expect(sortedMap.keys, orderedEquals(['b', 'c', 'a']));
      expect(sortedMap['a'], isA<Set>());
      expect(sortedMap['a'], orderedEquals(['q', 'x', 'z']));
    });

    test('Nested map', () {
      final map = {
        'c': 'c',
        'a': {'x': 'c', 'z': 'b', 'q': 'a'},
        'b': 'b'
      };
      final sortedMap = map.deepSortByValue();

      expect(sortedMap.keys, orderedEquals(['b', 'c', 'a']));
      expect(sortedMap['a'], isMap);
      expect((sortedMap['a'] as Map).values, orderedEquals(['a', 'b', 'c']));
    });

    test('Nested two lists - sort by length', () {
      final map = {
        'c': 'c',
        'a': ['x', 'a', 'd', 'g'],
        'd': ['x', 'a', 'd'],
        'b': 'b'
      };
      final sortedMap = map.deepSortByValue();

      expect(sortedMap.keys, orderedEquals(['b', 'c', 'd', 'a']));
      expect(sortedMap['d'], isList);
      expect(sortedMap['d'], orderedEquals(['a', 'd', 'x']));
      expect(sortedMap['a'], isList);
      expect(sortedMap['a'], orderedEquals(['a', 'd', 'g', 'x']));
    });

    test('Nested two Sets - sort by length', () {
      final map = {
        'c': 'c',
        'a': {'x', 'a', 'd', 'g'},
        'd': {'x', 'a', 'd'},
        'b': 'b'
      };
      final sortedMap = map.deepSortByValue();

      expect(sortedMap.keys, orderedEquals(['b', 'c', 'd', 'a']));
      expect(sortedMap['d'], isA<Set>());
      expect(sortedMap['d'], orderedEquals(['a', 'd', 'x']));
      expect(sortedMap['a'], isA<Set>());
      expect(sortedMap['a'], orderedEquals(['a', 'd', 'g', 'x']));
    });

    test('Nested two Maps - sort by length', () {
      final map = {
        'c': 'c',
        'a': {'x': 'xx', 'a': 'aa', 'd': 'dd', 'g': 'gg'},
        'd': {'x': 'xx', 'a': 'aa', 'd': 'dd'},
        'b': 'b'
      };
      final sortedMap = map.deepSortByValue();

      expect(sortedMap.keys, orderedEquals(['b', 'c', 'd', 'a']));
      expect((sortedMap['d'] as Map).values, orderedEquals(['aa', 'dd', 'xx']));
      expect((sortedMap['a'] as Map).values,
          orderedEquals(['aa', 'dd', 'gg', 'xx']));
    });

    test('Type order', () {
      final map = {
        'a': {'b', 'a'},
        'c': 'a',
        'b': 2.2,
        2: 2,
        'd': {'b': 'bb', 'a': 'aa'},
        1: ['b', 'a'],
        3: 1.1,
        5: 1,
      };
      final sortedMap = map.deepSortByValue();

      expect(sortedMap.values.elementAt(0), isA<int>());
      expect(sortedMap.values.elementAt(1), isA<double>());
      expect(sortedMap.values.elementAt(2), isA<int>());
      expect(sortedMap.values.elementAt(3), isA<double>());
      expect(sortedMap.values.elementAt(4), isA<String>());
      expect(sortedMap.values.elementAt(5), isList);
      expect(sortedMap.values.elementAt(6), isA<Set>());
      expect(sortedMap.values.elementAt(7), isMap);
    });
  });

  // ###########################################################################

  group('Map - deepDifferenceByValue()', () {
    test('no diff', () {
      final map1 = {
        'f': false,
        'a': 'aa',
        'g': 3.3,
        'b': 3,
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
      };
      final map2 = {
        'f': false,
        'a': 'aa',
        'g': 3.3,
        'b': 3,
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
      };
      ;
      final diff = map1.deepDifferenceByValue(map2);

      expect(diff, hasLength(0));
    });

    test('diff in type under `g` key - double vs string', () {
      final map1 = {
        'f': false,
        'a': 'aa',
        'g': 3.3,
        'b': 3,
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
      };
      final map2 = {
        'f': false,
        'a': 'aa',
        'g': '3.3',
        'b': 3,
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
      };
      ;
      final diff = map1.deepDifferenceByValue(map2);

      expect(diff, hasLength(1));
      expect(diff['g'], equals(3.3));
    });

    test('swap values from `f` and `e`', () {
      final map1 = {
        'f': true,
        'a': 'aa',
        'g': 3.3,
        'b': 3,
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': false,
      };
      final map2 = {
        'f': false,
        'a': 'aa',
        'g': 3.3,
        'b': 3,
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
      };
      ;
      final diff = map1.deepDifferenceByValue(map2);

      expect(diff, hasLength(2));
      expect(diff.keys, orderedEquals(['f', 'e']));
      expect(diff.values, orderedEquals([true, false]));
    });

    test('one diff per type - except null', () {
      final map1 = {
        'f': false,
        'a': 'aa',
        'g': 3.3,
        'b': 3,
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
      };
      final map2 = {
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
      };
      ;
      final diff = map1.deepDifferenceByValue(map2);

      expect(diff.values, orderedEquals([false, 'aa', 3.3, 3]));
      expect(diff.keys, orderedEquals(['f', 'a', 'g', 'b']));
    });

    test('nested map - no diff', () {
      final map1 = {
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
        'j': {
          'f': false,
          'a': 'aa',
          'g': 3.3,
          'b': 3,
        },
      };
      final map2 = {
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
        'j': {
          'f': false,
          'a': 'aa',
          'g': 3.3,
          'b': 3,
        },
      };
      ;
      final diff = map1.deepDifferenceByValue(map2);

      expect(diff, hasLength(0));
    });

    test('nested map - swap keys `e` & `j`', () {
      final map1 = {
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
        'j': {
          'f': false,
          'a': 'aa',
          'g': 3.3,
          'b': 3,
        },
      };
      final map2 = {
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'j': true,
        'e': {
          'f': false,
          'a': 'aa',
          'g': 3.3,
          'b': 3,
        },
      };
      ;
      final diff = map1.deepDifferenceByValue(map2);

      expect(diff, hasLength(2));
      expect(diff.keys, unorderedEquals(['e', 'j']));
      expect(diff['e'], equals(true));
      expect((diff['j'] as Map).values, orderedEquals([false, 'aa', 3.3, 3]));
    });

    test('nested map - diff in nested map', () {
      final map1 = {
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
        'j': {
          'f': false,
          'a': 'aa',
          'g': 3.3,
          'b': 3,
        },
      };
      final map2 = {
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
        'j': {
          'g': 3.3,
          'b': 3,
        },
      };
      ;
      final diff = map1.deepDifferenceByValue(map2);

      expect(diff, hasLength(1));
      expect((diff['j'] as Map).keys, orderedEquals(['f', 'a']));
      expect((diff['j'] as Map).values, orderedEquals([false, 'aa']));
    });
  });

  // ###########################################################################

  group('Map - deepDifferenceByKey()', () {
    test('no diff', () {
      final map1 = {
        'f': false,
        'a': 'aa',
        'g': 3.3,
        'b': 3,
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
      };
      final map2 = {
        'f': false,
        'a': 'aa',
        'g': 3.3,
        'b': 3,
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
      };
      ;
      final diff = map1.deepDifferenceByKey(map2);

      expect(diff, hasLength(0));
    });

    test('no diff in keys - value diff under `g` key - double vs string', () {
      final map1 = {
        'f': false,
        'a': 'aa',
        'g': 3.3,
        'b': 3,
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
      };
      final map2 = {
        'f': false,
        'a': 'aa',
        'g': '3.3',
        'b': 3,
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
      };
      ;
      final diff = map1.deepDifferenceByKey(map2);

      expect(diff, hasLength(0));
    });

    test('swap values from `f` and `e` - no keys diff', () {
      final map1 = {
        'f': true,
        'a': 'aa',
        'g': 3.3,
        'b': 3,
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': false,
      };
      final map2 = {
        'f': false,
        'a': 'aa',
        'g': 3.3,
        'b': 3,
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
      };
      ;
      final diff = map1.deepDifferenceByKey(map2);

      expect(diff, hasLength(0));
    });

    test('missing few keys', () {
      final map1 = {
        'f': false,
        'a': 'aa',
        'g': 3.3,
        'b': 3,
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
      };
      final map2 = {
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
      };
      ;
      final diff = map1.deepDifferenceByKey(map2);

      expect(diff.values, orderedEquals([false, 'aa', 3.3, 3]));
      expect(diff.keys, orderedEquals(['f', 'a', 'g', 'b']));
    });

    test('nested map - no diff', () {
      final map1 = {
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
        'j': {
          'f': false,
          'a': 'aa',
          'g': 3.3,
          'b': 3,
        },
      };
      final map2 = {
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
        'j': {
          'f': false,
          'a': 'aa',
          'g': 3.3,
          'b': 3,
        },
      };
      ;
      final diff = map1.deepDifferenceByKey(map2);

      expect(diff, hasLength(0));
    });

    test('nested map - swap keys `e` & `j` - submap under `j` differs', () {
      final map1 = {
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
        'j': {
          'f': false,
          'a': 'aa',
          'g': 3.3,
          'b': 3,
        },
      };
      final map2 = {
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'j': true,
        'e': {
          'f': false,
          'a': 'aa',
          'g': 3.3,
          'b': 3,
        },
      };
      ;
      final diff = map1.deepDifferenceByKey(map2);

      expect(diff.keys, orderedEquals(['j']));
      expect((diff['j'] as Map).keys, orderedEquals(['f', 'a', 'g', 'b']));
    });

    test('nested map - diff in nested map', () {
      final map1 = {
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
        'j': {
          'f': false,
          'a': 'aa',
          'g': 3.3,
          'b': 3,
        },
      };
      final map2 = {
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
        'j': {
          'g': 3.3,
          'b': 3,
        },
      };
      ;
      final diff = map1.deepDifferenceByKey(map2);

      expect(diff, hasLength(1));
      expect((diff['j'] as Map).keys, orderedEquals(['f', 'a']));
      expect((diff['j'] as Map).values, orderedEquals([false, 'aa']));
    });
  });

  // ###########################################################################

  group('Map - deepIntersectionByValue()', () {
    test('All intersection', () {
      final map1 = {
        'f': false,
        'a': 'aa',
        'g': 3.3,
        'b': 3,
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
      };
      final map2 = {
        'f': false,
        'a': 'aa',
        'g': 3.3,
        'b': 3,
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
      };
      ;
      final intersection = map1.deepIntersectionByValue(map2);

      expect(intersection.keys,
          orderedEquals(['f', 'a', 'g', 'b', 'h', 'c', 'i', 'd', 'e']));
      expect(intersection.values,
          orderedEquals([false, 'aa', 3.3, 3, 'hh', 2.2, 1, null, true]));
    });

    test('diff in type under `g` key - double vs string', () {
      final map1 = {
        'f': false,
        'a': 'aa',
        'g': 3.3,
        'b': 3,
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
      };
      final map2 = {
        'f': false,
        'a': 'aa',
        'g': '3.3',
        'b': 3,
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
      };
      ;
      final intersection = map1.deepIntersectionByValue(map2);

      expect(intersection.keys,
          orderedEquals(['f', 'a', 'b', 'h', 'c', 'i', 'd', 'e']));
    });

    test('swap values from `f` and `e`', () {
      final map1 = {
        'f': true,
        'a': 'aa',
        'g': 3.3,
        'b': 3,
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': false,
      };
      final map2 = {
        'f': false,
        'a': 'aa',
        'g': 3.3,
        'b': 3,
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
      };
      ;
      final intersection = map1.deepIntersectionByValue(map2);

      expect(intersection.keys,
          orderedEquals(['a', 'g', 'b', 'h', 'c', 'i', 'd']));
    });

    test('one diff per type - except null', () {
      final map1 = {
        'f': false,
        'a': 'aa',
        'g': 3.3,
        'b': 3,
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
      };
      final map2 = {
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
      };
      ;
      final intersection = map1.deepIntersectionByValue(map2);

      expect(intersection.keys, orderedEquals(['h', 'c', 'i', 'd', 'e']));
    });

    test('nested map - no diff', () {
      final map1 = {
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
        'j': {
          'f': false,
          'a': 'aa',
          'g': 3.3,
          'b': 3,
        },
      };
      final map2 = {
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
        'j': {
          'f': false,
          'a': 'aa',
          'g': 3.3,
          'b': 3,
        },
      };
      ;
      final intersection = map1.deepIntersectionByValue(map2);

      expect(intersection.keys, orderedEquals(['h', 'c', 'i', 'd', 'e', 'j']));
      expect(
          (intersection['j'] as Map).keys, orderedEquals(['f', 'a', 'g', 'b']));
      expect((intersection['j'] as Map).values,
          orderedEquals([false, 'aa', 3.3, 3]));
    });

    test('nested map - swap keys `e` & `j`', () {
      final map1 = {
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
        'j': {
          'f': false,
          'a': 'aa',
          'g': 3.3,
          'b': 3,
        },
      };
      final map2 = {
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'j': true,
        'e': {
          'f': false,
          'a': 'aa',
          'g': 3.3,
          'b': 3,
        },
      };
      ;
      final intersection = map1.deepIntersectionByValue(map2);

      expect(intersection.keys, orderedEquals(['h', 'c', 'i', 'd']));
    });

    test('nested map - diff in nested map', () {
      final map1 = {
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
        'j': {
          'f': false,
          'a': 'aa',
          'g': 3.3,
          'b': 3,
        },
      };
      final map2 = {
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
        'j': {
          'g': 3.3,
          'b': 3,
        },
      };
      ;
      final intersection = map1.deepIntersectionByValue(map2);

      expect(intersection.keys, orderedEquals(['h', 'c', 'i', 'd', 'e', 'j']));
      expect((intersection['j'] as Map).keys, orderedEquals(['g', 'b']));
      expect((intersection['j'] as Map).values, orderedEquals([3.3, 3]));
    });
  });

  // ###########################################################################

  group('Map - deepIntersectionByKey()', () {
    test('All intersection', () {
      final map1 = {
        'f': false,
        'a': 'aa',
        'g': 3.3,
        'b': 3,
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
      };
      final map2 = {
        'f': false,
        'a': 'aa',
        'g': 3.3,
        'b': 3,
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
      };
      ;
      final intersection = map1.deepIntersectionByKey(map2);

      expect(intersection.keys,
          orderedEquals(['f', 'a', 'g', 'b', 'h', 'c', 'i', 'd', 'e']));
    });

    test('all keys intersect: diff in type under `g` - double vs string', () {
      final map1 = {
        'f': false,
        'a': 'aa',
        'g': 3.3,
        'b': 3,
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
      };
      final map2 = {
        'f': false,
        'a': 'aa',
        'g': '3.3',
        'b': 3,
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
      };
      ;
      final intersection = map1.deepIntersectionByKey(map2);

      expect(intersection.keys,
          orderedEquals(['f', 'a', 'g', 'b', 'h', 'c', 'i', 'd', 'e']));
    });

    test('all keys intersect: swap values from `f` and `e`', () {
      final map1 = {
        'f': true,
        'a': 'aa',
        'g': 3.3,
        'b': 3,
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': false,
      };
      final map2 = {
        'f': false,
        'a': 'aa',
        'g': 3.3,
        'b': 3,
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
      };
      ;
      final intersection = map1.deepIntersectionByKey(map2);

      expect(intersection.keys,
          orderedEquals(['f', 'a', 'g', 'b', 'h', 'c', 'i', 'd', 'e']));
    });

    test('one diff per type - except null', () {
      final map1 = {
        'f': false,
        'a': 'aa',
        'g': 3.3,
        'b': 3,
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
      };
      final map2 = {
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
      };
      ;
      final intersection = map1.deepIntersectionByKey(map2);

      expect(intersection.keys, orderedEquals(['h', 'c', 'i', 'd', 'e']));
    });

    test('nested map - no diff', () {
      final map1 = {
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
        'j': {
          'f': false,
          'a': 'aa',
          'g': 3.3,
          'b': 3,
        },
      };
      final map2 = {
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
        'j': {
          'f': false,
          'a': 'aa',
          'g': 3.3,
          'b': 3,
        },
      };
      ;
      final intersection = map1.deepIntersectionByKey(map2);

      expect(intersection.keys, orderedEquals(['h', 'c', 'i', 'd', 'e', 'j']));
      expect(
          (intersection['j'] as Map).keys, orderedEquals(['f', 'a', 'g', 'b']));
      expect((intersection['j'] as Map).values,
          orderedEquals([false, 'aa', 3.3, 3]));
    });

    test('nested map - swap keys `e` & `j`', () {
      final map1 = {
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
        'j': {
          'f': false,
          'a': 'aa',
          'g': 3.3,
          'b': 3,
        },
      };
      final map2 = {
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'j': true,
        'e': {
          'f': false,
          'a': 'aa',
          'g': 3.3,
          'b': 3,
        },
      };
      ;
      final intersection = map1.deepIntersectionByKey(map2);

      expect(intersection.keys, orderedEquals(['h', 'c', 'i', 'd', 'e', 'j']));
      expect(intersection['e'], isTrue);
      expect(intersection['j'], isMap);
      expect(intersection['j'], hasLength(0));
    });

    test('nested map - diff in nested map', () {
      final map1 = {
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
        'j': {
          'f': false,
          'a': 'aa',
          'g': 3.3,
          'b': 3,
        },
      };
      final map2 = {
        'h': 'hh',
        'c': 2.2,
        'i': 1,
        'd': null,
        'e': true,
        'j': {
          'g': 3.3,
          'b': 3,
        },
      };
      ;
      final intersection = map1.deepIntersectionByKey(map2);

      expect(intersection.keys, orderedEquals(['h', 'c', 'i', 'd', 'e', 'j']));
      expect((intersection['j'] as Map).keys, orderedEquals(['g', 'b']));
    });
  });
}
