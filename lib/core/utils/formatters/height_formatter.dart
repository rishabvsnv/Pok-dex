abstract final class HeightFormatter {
  HeightFormatter._();

  static String format(int height) {
    final meters = height / 10;

    return '${meters.toStringAsFixed(1)} m';
  }
}
