class PokemonModel {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final int height;
  final int weight;
  final List<String> abilities;
  final Map<String, int> stats;
  final String description;

  const PokemonModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.height,
    required this.weight,
    required this.abilities,
    required this.stats,
    required this.description,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      id: json['id'] ?? 0,

      name: json['name'] ?? '',

      imageUrl:
          json['sprites']?['other']?['official-artwork']?['front_default'] ??
          '',

      types:
          (json['types'] as List?)
              ?.map((e) => e['type']?['name']?.toString() ?? '')
              .where((e) => e.isNotEmpty)
              .toList() ??
          [],

      height: json['height'] ?? 0,

      weight: json['weight'] ?? 0,

      abilities:
          (json['abilities'] as List?)
              ?.map((e) => e['ability']?['name']?.toString() ?? '')
              .where((e) => e.isNotEmpty)
              .toList() ??
          [],

      stats: {
        for (final stat in (json['stats'] as List?) ?? [])
          stat['stat']['name']?.toString() ?? '': stat['base_stat'] ?? 0,
      },

      // PokeAPI pokemon endpoint does NOT have description
      description: '',
    );
  }
}
