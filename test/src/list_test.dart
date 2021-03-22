import 'package:deep_collection/deep_collection.dart';
import 'package:test/test.dart';

import '../models/test_model.dart';

void main() {
  group('List - deepReverse()', () {
    test('Simple list - strings', () {
      final list = ['a', 'c', 'b'];
      final reversedList = list.deepReverse();

      expect(reversedList, hasLength(list.length));
      expect(reversedList, orderedEquals(['b', 'c', 'a']));
    });

    test('Simple list - integers', () {
      final list = [1, 3, 2];
      final reversedList = list.deepReverse();

      expect(reversedList, hasLength(list.length));
      expect(reversedList, orderedEquals([2, 3, 1]));
    });

    test('Simple list - double', () {
      final list = [1.3, 3.2, 2.1];
      final reversedList = list.deepReverse();

      expect(reversedList, hasLength(list.length));
      expect(reversedList, orderedEquals([2.1, 3.2, 1.3]));
    });

    test(
        'Simple list - various types: '
        'strings, doubles, bool, null & integers', () {
      final list = [null, true, false, 1.3, 'b', 3.2, 2, 1, 'a', 'c', 3, 2.1];
      final reversedList = list.deepReverse();

      expect(reversedList, hasLength(list.length));
      expect(
          reversedList,
          orderedEquals(
              [2.1, 3, 'c', 'a', 1, 2, 3.2, 'b', 1.3, false, true, null]));
    });

    test('Nested List', () {
      final list = [
        'c',
        ['q', 's'],
        'b'
      ];
      final reversedList = list.deepReverse();

      expect(reversedList, hasLength(list.length));
      expect(reversedList[1], isList);
      expect(reversedList[1], orderedEquals(['s', 'q']));
    });

    test('Nested Set', () {
      final list = [
        'c',
        {'q', 's'},
        'b',
      ];
      final reversedList = list.deepReverse();

      expect(reversedList, hasLength(list.length));
      expect(reversedList[1], isA<Set>());
      expect(reversedList[1], orderedEquals(['s', 'q']));
    });

    test('Nested Map', () {
      final list = [
        'c',
        {'q': 'qq', 's': 'ss'},
        'b',
      ];
      final reversedList = list.deepReverse();

      expect(reversedList, hasLength(list.length));
      expect(reversedList[1], isMap);
      expect((reversedList[1] as Map).keys, orderedEquals(['s', 'q']));
    });
  });

  group('List - deepSort()', () {
    test('Simple list - strings', () {
      final list = ['a', 'c', 'b'];
      final sortedList = list.deepSort();

      expect(sortedList, hasLength(list.length));
      expect(sortedList, orderedEquals(['a', 'b', 'c']));
    });

    test('Simple list - integers', () {
      final list = [1, 3, 2];
      final sortedList = list.deepSort();

      expect(sortedList, hasLength(list.length));
      expect(sortedList, orderedEquals([1, 2, 3]));
    });

    test('Simple list - double', () {
      final list = [1.3, 3.2, 2.1];
      final sortedList = list.deepSort();

      expect(sortedList, hasLength(list.length));
      expect(sortedList, orderedEquals([1.3, 2.1, 3.2]));
    });

    test('Simple list - excluding bool & null', () {
      final list = [1.3, 3.2, 2.1, null, true, false];
      final sortedList = list.deepSort();

      expect(sortedList, hasLength(list.length - 3));
      expect(sortedList, orderedEquals([1.3, 2.1, 3.2]));
    });

    test('Simple list - various types: strings, doubles & integers', () {
      final list = [1.3, 'b', 3.2, 2, 1, 'a', 'c', 3, 2.1];
      final sortedList = list.deepSort();

      expect(sortedList, hasLength(list.length));
      expect(
          sortedList, orderedEquals([1, 1.3, 2, 2.1, 3, 3.2, 'a', 'b', 'c']));
    });

    test('Nested List', () {
      final list = [
        'c',
        ['x', 'a', 'd'],
        'b'
      ];
      final sortedList = list.deepSort();

      expect(sortedList, hasLength(list.length));
      expect(sortedList[0], equals('b'));
      expect(sortedList[1], equals('c'));
      expect(sortedList[2], isList);
      expect(sortedList[2], orderedEquals(['a', 'd', 'x']));
    });

    test('Nested set', () {
      final list = [
        'c',
        {'x', 'z', 'q'},
        'b'
      ];
      final sortedList = list.deepSort();

      expect(sortedList[2], isA<Set>());
      expect(sortedList[2], orderedEquals(['q', 'x', 'z']));
    });

    test('Nested map', () {
      final list = [
        'c',
        {'x': 'c', 'z': 'b', 'q': 'a'},
        'b'
      ];
      final sortedList = list.deepSort();

      expect(sortedList[2], isMap);
      expect((sortedList[2] as Map).values, orderedEquals(['a', 'b', 'c']));
    });

    test('Nested two lists - sort by length', () {
      final list = [
        'c',
        ['x', 'a', 'd', 'g'],
        ['x', 'a', 'd'],
        'b'
      ];
      final sortedList = list.deepSort();

      expect(sortedList, hasLength(list.length));
      expect(sortedList[0], equals('b'));
      expect(sortedList[1], equals('c'));
      expect(sortedList[2], isList);
      expect(sortedList[2], orderedEquals(['a', 'd', 'x']));
      expect(sortedList[3], isList);
      expect(sortedList[3], orderedEquals(['a', 'd', 'g', 'x']));
    });

    test('Nested two Sets - sort by length', () {
      final list = [
        'c',
        {'x', 'a', 'd', 'g'},
        {'x', 'a', 'd'},
        'b'
      ];
      final sortedList = list.deepSort();

      expect(sortedList, hasLength(list.length));
      expect(sortedList[0], equals('b'));
      expect(sortedList[1], equals('c'));
      expect(sortedList[2], isA<Set>());
      expect(sortedList[2], orderedEquals(['a', 'd', 'x']));
      expect(sortedList[3], isA<Set>());
      expect(sortedList[3], orderedEquals(['a', 'd', 'g', 'x']));
    });

    test('Nested two Maps - sort by length', () {
      final list = [
        'c',
        {'x': 'xx', 'a': 'aa', 'd': 'dd', 'g': 'gg'},
        {'x': 'xx', 'a': 'aa', 'd': 'dd'},
        'b'
      ];
      final sortedList = list.deepSort();

      expect(sortedList, hasLength(list.length));
      expect(sortedList[0], equals('b'));
      expect(sortedList[1], equals('c'));
      expect((sortedList[2] as Map).keys, orderedEquals(['a', 'd', 'x']));
      expect((sortedList[3] as Map).keys, orderedEquals(['a', 'd', 'g', 'x']));
    });

    test('Type order', () {
      final list = [
        {'b', 'a'},
        'a',
        2.2,
        2,
        {'b': 'bb', 'a': 'aa'},
        ['b', 'a'],
        1.1,
        1,
      ];
      final sortedList = list.deepSort();

      expect(sortedList, hasLength(list.length));
      expect(sortedList[0], isA<int>());
      expect(sortedList[1], isA<double>());
      expect(sortedList[2], isA<int>());
      expect(sortedList[3], isA<double>());
      expect(sortedList[4], isA<String>());
      expect(sortedList[5], isList);
      expect(sortedList[6], isA<Set>());
      expect(sortedList[7], isMap);
    });
  });

  group('List - deepCopy()', () {
    test('Simple list of strings', () {
      final list = ['a', 'c', 'x'];
      expect(list.deepCopy(), list);
    });

    test('Nested list', () {
      final list = [
        'a',
        'c',
        ['a', 'c'],
        'x'
      ];
      expect(list.deepCopy(), list);
    });

    test('Nested set', () {
      final list = [
        'a',
        'c',
        {'a', 'c'},
        'x'
      ];
      expect(list.deepCopy(), list);
    });

    test('Nested map', () {
      final list = [
        'a',
        'c',
        {'a': 'b', 'c': 'd'},
        'x'
      ];
      expect(list.deepCopy(), list);
    });
  });

  group('List - deepSearchByValue()', () {
    test('Simple list of strings', () {
      final list = ['a', 'c', 'x'];
      expect(
        list.deepSearchByValue<String>((value) => value == 'c'),
        ['c'],
      );
    });

    test('Nested list of strings', () {
      final list = [
        'a',
        ['c', 'x']
      ];
      expect(
        list.deepSearchByValue<String>((value) => value == 'c'),
        [
          ['c']
        ],
      );
    });

    test('Simple list of objects', () {
      final list = [
        TestObject('a', 11),
        TestObject('b', 12),
        TestObject('c', 1),
      ];
      expect(
        list.deepSearchByValue<TestObject>(
            (value) => value.name == list.last.name),
        [list.last],
      );
    });

    test('Nested set of strings', () {
      final list = [
        'a',
        {'c', 'x'}
      ];
      expect(
        list.deepSearchByValue<String>((value) => value == 'c'),
        [
          {'c'}
        ],
      );
    });

    test('Nested map of strings', () {
      final list = [
        'a',
        {'c': 'd', 'x': 'z'}
      ];
      expect(
        list.deepSearchByValue<String>((value) => value == 'd'),
        [
          {'c': 'd'}
        ],
      );
    });
  });
}
