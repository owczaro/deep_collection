import 'package:deep_collection/deep_list.dart';

void main() {
  final list = [
    'z',
    'a',
    'c',
    ['x', 'q']
  ];

  print('\n_________________ Deep reverse ___________________________');
  print('Should be: [[q, x], c, a, z]');
  print(list.deepReverse());

  print('\n_________________ Deep sort ___________________________');
  print('Should be: [a, c, z, [q, x]]');
  print(list.deepSort());
}
