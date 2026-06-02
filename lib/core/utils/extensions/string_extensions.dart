extension StringExtensions on String {
  String get capitalize {
    if (isEmpty) return this;

    return this[0].toUpperCase() + substring(1);
  }

  String get capitalizeWords {
    return split(
      ' ',
    ).map((e) => e.isEmpty ? e : e[0].toUpperCase() + e.substring(1)).join(' ');
  }

  bool get isNetworkImage {
    return startsWith('http');
  }
}
