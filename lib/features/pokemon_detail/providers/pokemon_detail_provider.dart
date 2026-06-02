import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/data/models/pokemon/pokemon_model.dart';
import 'package:pokedex/features/home/repositories/pokemon_repository.dart';

final pokemonDetailProvider = FutureProvider.family<PokemonModel, int>((
  ref,
  id,
) async {
  final repository = ref.watch(pokemonRepositoryProvider);

  final response = await repository.getPokemonById(id);

  if (!response.success) {
    throw Exception(response.message);
  }

  return response.data!;
});
