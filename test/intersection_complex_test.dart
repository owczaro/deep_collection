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

  final expectedIntersectionByValue = {
    'd': {'x': 'y'},
    'w': 'm',
    'c': {'x': 'y'},
    true: null,
    false: {
      1.1: 1,
      'x': {777: 'x'}
    }
  };

  final expectedIntersectionByKey = {
    'a': 'b',
    'd': {'x': 'y', 'a': 'f'},
    'w': 'm',
    'c': {'x': 'y'},
    true: null,
    false: {
      1.1: 1,
      'q': 'q',
      'x': {777: 'x'}
    }
  };

  test('intersection by value complex', () {
    final intersection = map1.deepIntersectionByValue(map2);

    expect(intersection.toString(),
        equals(expectedIntersectionByValue.toString()));
  });

  test('intersection by key complex', () {
    final intersection = map1.deepIntersectionByKey(map2);

    expect(
        intersection.toString(), equals(expectedIntersectionByKey.toString()));
  });
}
