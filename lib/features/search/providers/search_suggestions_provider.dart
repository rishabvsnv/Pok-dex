import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/search/models/pokemon_search_model.dart';
import 'package:pokedex/features/search/providers/pokemon_search_list_provider.dart';
// import 'package:pokedex/features/search/models/pokemon_search_model.dart';
// import 'package:pokedex/features/search/providers/pokemon_search_list_provider.dart';
import 'package:pokedex/features/search/providers/search_provider.dart';

final searchSuggestionsProvider = Provider<List<PokemonSearchModel>>((ref) {
  final query = ref.watch(searchQueryProvider);

  final pokemonAsync = ref.watch(pokemonSearchListProvider);

  return pokemonAsync.when(
    data: (pokemons) {
      if (query.trim().isEmpty) {
        return [];
      }

      final lowercaseQuery = query.toLowerCase();

      return pokemons
          .where((pokemon) {
            return pokemon.name.toLowerCase().contains(lowercaseQuery);
          })
          .take(10)
          .toList();
    },

    loading: () => [],

    error: (_, _) => [],
  );
});
