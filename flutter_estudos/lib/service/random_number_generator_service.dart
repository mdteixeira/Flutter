import 'dart:math';

class RandomNumberGeneratorService {
  static int generateRandomNumber(int max) {
    Random generatedNumber = Random();
    return generatedNumber.nextInt(max);
  }
}
