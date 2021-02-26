import 'dart:math';

int randomValue(int min, int max) {
  final _random = new Random();

/**
 * Generates a positive random integer uniformly distributed on the range
 * from [min], inclusive, to [max], exclusive.
 */
  return min + _random.nextInt(max - min);
}
