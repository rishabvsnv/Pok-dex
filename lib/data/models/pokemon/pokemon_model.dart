class PokemonModel {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;

  const PokemonModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      id: json['id'],
      name: json['name'],
      imageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${json['id']}.png',

      types: (json['types'] as List)
          .map((e) => e['type']['name'].toString())
          .toList(),
    );
  }
}
