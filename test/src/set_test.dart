import 'package:deep_collection/deep_set.dart';
import 'package:test/test.dart';

void main() {
  group('Set - deepReverse()', () {
    test('Simple set - strings', () {
      final set = {'a', 'c', 'b'};
      final reversedSet = set.deepReverse();

      expect(reversedSet, hasLength(set.length));
      expect(reversedSet, orderedEquals(['b', 'c', 'a']));
    });

    test('Simple set - integers', () {
      final set = {1, 3, 2};
      final reversedSet = set.deepReverse();

      expect(reversedSet, hasLength(set.length));
      expect(reversedSet, orderedEquals([2, 3, 1]));
    });

    test('Simple set - double', () {
      final set = {1.3, 3.2, 2.1};
      final reversedSet = set.deepReverse();

      expect(reversedSet, hasLength(set.length));
      expect(reversedSet, orderedEquals([2.1, 3.2, 1.3]));
    });

    test(
        'Simple set - various types: '
        'strings, doubles, bool, null & integers', () {
      final set = {null, true, false, 1.3, 'b', 3.2, 2, 1, 'a', 'c', 3, 2.1};
      final reversedSet = set.deepReverse();

      expect(reversedSet, hasLength(set.length));
      expect(
          reversedSet,
          orderedEquals(
              [2.1, 3, 'c', 'a', 1, 2, 3.2, 'b', 1.3, false, true, null]));
    });

    test('Nested List', () {
      final set = {
        'c',
        ['q', 's'],
        'b'
      };
      final reversedSet = set.deepReverse();

      expect(reversedSet, hasLength(set.length));
      expect(reversedSet.elementAt(1), isList);
      expect(reversedSet.elementAt(1), orderedEquals(['s', 'q']));
    });

    test('Nested Set', () {
      final set = {
        'c',
        {'q', 's'},
        'b',
      };
      final reversedSet = set.deepReverse();

      expect(reversedSet, hasLength(set.length));
      expect(reversedSet.elementAt(1), isA<Set>());
      expect(reversedSet.elementAt(1), orderedEquals(['s', 'q']));
    });

    test('Nested Map', () {
      final set = {
        'c',
        {'q': 'qq', 's': 'ss'},
        'b',
      };
      final reversedSet = set.deepReverse();

      expect(reversedSet, hasLength(set.length));
      expect(reversedSet.elementAt(1), isMap);
      expect((reversedSet.elementAt(1) as Map).keys, orderedEquals(['s', 'q']));
    });
  });

  // ###########################################################################

  group('Set - deepSort()', () {
    test('Simple set - strings', () {
      final set = {'a', 'c', 'b'};
      final sortedSet = set.deepSort();

      expect(sortedSet, hasLength(set.length));
      expect(sortedSet, orderedEquals(['a', 'b', 'c']));
    });

    test('Simple set - integers', () {
      final set = {1, 3, 2};
      final sortedSet = set.deepSort();

      expect(sortedSet, hasLength(set.length));
      expect(sortedSet, orderedEquals([1, 2, 3]));
    });

    test('Simple set - double', () {
      final set = {1.3, 3.2, 2.1};
      final sortedSet = set.deepSort();

      expect(sortedSet, hasLength(set.length));
      expect(sortedSet, orderedEquals([1.3, 2.1, 3.2]));
    });

    test('Simple set - excluding bool & null', () {
      final set = {1.3, 3.2, 2.1, null, true, false};
      final sortedSet = set.deepSort();

      expect(sortedSet, hasLength(set.length - 3));
      expect(sortedSet, orderedEquals([1.3, 2.1, 3.2]));
    });

    test('Simple set - various types: strings, doubles & integers', () {
      final set = {1.3, 'b', 3.2, 2, 1, 'a', 'c', 3, 2.1};
      final sortedSet = set.deepSort();

      expect(sortedSet, hasLength(set.length));
      expect(sortedSet, orderedEquals([1, 1.3, 2, 2.1, 3, 3.2, 'a', 'b', 'c']));
    });

    test('Nested List', () {
      final set = {
        'c',
        ['x', 'a', 'd'],
        'b'
      };
      final sortedSet = set.deepSort();

      expect(sortedSet, hasLength(set.length));
      expect(sortedSet.elementAt(0), equals('b'));
      expect(sortedSet.elementAt(1), equals('c'));
      expect(sortedSet.elementAt(2), isList);
      expect(sortedSet.elementAt(2), orderedEquals(['a', 'd', 'x']));
    });

    test('Nested set', () {
      final set = {
        'c',
        {'x', 'z', 'q'},
        'b'
      };
      final sortedSet = set.deepSort();

      expect(sortedSet.elementAt(2), isA<Set>());
      expect(sortedSet.elementAt(2), orderedEquals(['q', 'x', 'z']));
    });

    test('Nested map', () {
      final set = {
        'c',
        {'x': 'c', 'z': 'b', 'q': 'a'},
        'b'
      };
      final sortedSet = set.deepSort();

      expect(sortedSet.elementAt(2), isMap);
      expect((sortedSet.elementAt(2) as Map).values,
          orderedEquals(['a', 'b', 'c']));
    });

    test('Nested two lists - sort by length', () {
      final set = {
        'c',
        ['x', 'a', 'd', 'g'],
        ['x', 'a', 'd'],
        'b'
      };
      final sortedSet = set.deepSort();

      expect(sortedSet, hasLength(set.length));
      expect(sortedSet.elementAt(0), equals('b'));
      expect(sortedSet.elementAt(1), equals('c'));
      expect(sortedSet.elementAt(2), isList);
      expect(sortedSet.elementAt(2), orderedEquals(['a', 'd', 'x']));
      expect(sortedSet.elementAt(3), isList);
      expect(sortedSet.elementAt(3), orderedEquals(['a', 'd', 'g', 'x']));
    });

    test('Nested two Sets - sort by length', () {
      final set = {
        'c',
        {'x', 'a', 'd', 'g'},
        {'x', 'a', 'd'},
        'b'
      };
      final sortedSet = set.deepSort();

      expect(sortedSet, hasLength(set.length));
      expect(sortedSet.elementAt(0), equals('b'));
      expect(sortedSet.elementAt(1), equals('c'));
      expect(sortedSet.elementAt(2), isA<Set>());
      expect(sortedSet.elementAt(2), orderedEquals(['a', 'd', 'x']));
      expect(sortedSet.elementAt(3), isA<Set>());
      expect(sortedSet.elementAt(3), orderedEquals(['a', 'd', 'g', 'x']));
    });

    test('Nested two Maps - sort by length', () {
      final set = {
        'c',
        {'x': 'xx', 'a': 'aa', 'd': 'dd', 'g': 'gg'},
        {'x': 'xx', 'a': 'aa', 'd': 'dd'},
        'b'
      };
      final sortedSet = set.deepSort();

      expect(sortedSet, hasLength(set.length));
      expect(sortedSet.elementAt(0), equals('b'));
      expect(sortedSet.elementAt(1), equals('c'));
      expect(
          (sortedSet.elementAt(2) as Map).keys, orderedEquals(['a', 'd', 'x']));
      expect((sortedSet.elementAt(3) as Map).keys,
          orderedEquals(['a', 'd', 'g', 'x']));
    });

    test('Type order', () {
      final set = {
        {'b', 'a'},
        'a',
        2.2,
        2,
        {'b': 'bb', 'a': 'aa'},
        ['b', 'a'],
        1.1,
        1,
      };
      final sortedSet = set.deepSort();

      expect(sortedSet, hasLength(set.length));
      expect(sortedSet.elementAt(0), isA<int>());
      expect(sortedSet.elementAt(1), isA<double>());
      expect(sortedSet.elementAt(2), isA<int>());
      expect(sortedSet.elementAt(3), isA<double>());
      expect(sortedSet.elementAt(4), isA<String>());
      expect(sortedSet.elementAt(5), isList);
      expect(sortedSet.elementAt(6), isA<Set>());
      expect(sortedSet.elementAt(7), isMap);
    });
  });
}
