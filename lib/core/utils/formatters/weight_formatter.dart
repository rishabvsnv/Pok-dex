abstract final class WeightFormatter {
  WeightFormatter._();

  static String format(int weight) {
    final kg = weight / 10;

    return '${kg.toStringAsFixed(1)} kg';
  }
}
