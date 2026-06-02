extension PokemonIdExtension on int {
  String get formattedPokemonId {
    return '#${toString().padLeft(3, '0')}';
  }
}

extension PokemonNameExtension on String {
  String get capitalizePokemonName {
    if (isEmpty) return this;

    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}
