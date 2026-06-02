import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/data/models/pokemon/pokemon_model.dart';
import 'package:pokedex/features/home/repositories/pokemon_repository.dart';

final pokemonListProvider = FutureProvider<List<PokemonModel>>((ref) async {
  final response = await ref.watch(pokemonRepositoryProvider).getPokemons();

  if (!response.success) {
    throw Exception(response.message);
  }

  return response.data ?? [];
});
