class PokemonSearchModel {
  final String name;
  final String url;

  const PokemonSearchModel({required this.name, required this.url});

  factory PokemonSearchModel.fromJson(Map<String, dynamic> json) {
    return PokemonSearchModel(name: json['name'] ?? '', url: json['url'] ?? '');
  }

  int get id {
    final segments = url.split('/').where((e) => e.isNotEmpty).toList();

    return int.tryParse(segments.last) ?? 0;
  }

  String get imageUrl {
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
  }
}
