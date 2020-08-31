import 'package:deep_collection/deep_set.dart';

void main() {
  final set = {
    'z',
    'a',
    {'x', 'q'},
    'c',
  };

  print('\n____________________ Deep reverse ______________________________');
  print('Should be: {c, {q, x}, a, z}');
  print(set.deepReverse());

  print('\n____________________ Deep sort ______________________________');
  print('Should be: {a, c, z, {q, x}}');
  print(set.deepSort());
}
