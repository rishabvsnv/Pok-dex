abstract final class IdFormatter {
  IdFormatter._();

  static String format(int id) {
    return '#${id.toString().padLeft(3, '0')}';
  }
}
