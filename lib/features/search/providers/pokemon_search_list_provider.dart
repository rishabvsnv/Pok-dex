import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/home/repositories/pokemon_repository.dart';
import 'package:pokedex/features/search/models/pokemon_search_model.dart';

final pokemonSearchListProvider = FutureProvider<List<PokemonSearchModel>>((
  ref,
) async {
  return ref.watch(pokemonRepositoryProvider).getPokemonSearchList();
});
