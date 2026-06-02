import 'package:flutter_riverpod/legacy.dart';
import 'package:pokedex/data/models/pokemon/pokemon_model.dart';

class FavoritesNotifier extends StateNotifier<List<PokemonModel>> {
  FavoritesNotifier() : super([]);

  bool isFavorite(int pokemonId) {
    return state.any((pokemon) => pokemon.id == pokemonId);
  }

  void toggleFavorite(PokemonModel pokemon) {
    final exists = isFavorite(pokemon.id);

    if (exists) {
      state = state.where((p) {
        return p.id != pokemon.id;
      }).toList();
    } else {
      state = [...state, pokemon];
    }
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<PokemonModel>>((ref) {
      return FavoritesNotifier();
    });
