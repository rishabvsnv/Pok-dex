import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/data/models/pokemon/pokemon_model.dart';
import 'package:pokedex/features/home/providers/pokemon_pagination_provider.dart';
import 'package:pokedex/features/search/providers/search_provider.dart';

final filteredPokemonProvider = Provider<AsyncValue<List<PokemonModel>>>((ref) {
  final pokemonState = ref.watch(pokemonPaginationProvider);

  final query = ref.watch(searchQueryProvider);

  return pokemonState.whenData((pokemons) {
    if (query.trim().isEmpty) {
      return pokemons;
    }

    final lowercaseQuery = query.toLowerCase();

    return pokemons.where((pokemon) {
      return pokemon.name.toLowerCase().contains(lowercaseQuery) ||
          pokemon.id.toString().contains(lowercaseQuery) ||
          pokemon.types.any(
            (type) => type.toLowerCase().contains(lowercaseQuery),
          );
    }).toList();
  });
});
