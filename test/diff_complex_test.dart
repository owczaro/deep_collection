import 'package:deep_collection/deep_collection.dart';
import 'package:test/test.dart';

void main() {
  final map1 = {
    'a': 'b',
    'd': {'x': 'y', 'a': 'f'},
    's': {'s': 'ss'},
    'w': 'm',
    'c': {'x': 'y', null: null},
    true: null,
    false: {
      1.1: 1,
      'q': 'q',
      'x': {
        777: 'x',
        false: {false: false},
      }
    },
  };
  final map2 = {
    'a': 'bb',
    'd': {'x': 'y', 'a': 'ff'},
    'w': 'm',
    'c': {'x': 'y', true: null},
    true: null,
    false: {
      1.1: 1,
      'q': 'qe',
      'x': {
        777: 'x',
        88: 'y',
      }
    },
  };

  final expectedDiff = {
    'a': 'b',
    'd': {'a': 'f'},
    's': {'s': 'ss'},
    'c': {null: null},
    false: {
      'q': 'q',
      'x': {
        false: {false: false}
      }
    }
  };

  test('diff complex', () {
    final diff = map1.deepDifference(map2);

    expect(diff.toString(), equals(expectedDiff.toString()));
  });
}
