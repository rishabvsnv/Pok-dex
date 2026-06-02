import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/data/models/pokemon/pokemon_model.dart';
import 'package:pokedex/features/home/repositories/pokemon_repository.dart';

final searchPokemonProvider = FutureProvider.family<PokemonModel?, String>((
  ref,
  query,
) async {
  if (query.trim().isEmpty) {
    return null;
  }

  final repository = ref.watch(pokemonRepositoryProvider);

  final response = await repository.getPokemonByName(query.toLowerCase());

  if (!response.success) {
    return null;
  }

  return response.data;
});
